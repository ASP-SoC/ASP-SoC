#!python

from numpy import cos, sin, pi, absolute, arange, log10, imag, real, arctan2, unwrap, angle
from scipy.signal import kaiserord, lfilter, firwin, freqz
from pylab import figure, clf, plot, xlabel, ylabel, xlim, ylim, title, grid, axes, show, savefig
import sys
import matplotlib.pyplot as plt
from PIL import Image
import matplotlib.lines as mlines
import matplotlib.patches as mpatches

plt.style.use('ggplot')

Order = 0

# ----------------------------------------------
# available window functions:
# boxcar, triang, blackman, hamming, hann, bartlett, flattop
# parzen, bohman, blackmanharris, nuttall, barthann, kaiser, gaussian
# general_gaussian, slepian, chebwin, exponential, tukey
# ----------------------------------------------

#------------------------------------------------
# Create a FIR filter
#------------------------------------------------
            
def designFIR_LP(sample_rate, width_hz, ripple_db, cutoff_hz, order_scale):

    # The Nyquist rate of the signal.
    nyq_rate = sample_rate / 2.0

    # The desired width of the transition from pass to stop,
    # relative to the Nyquist rate.  We'll design the filter
    # with a 5 Hz transition width.
    width = width_hz/nyq_rate

    # Compute the order and Kaiser parameter for the FIR filter.
    N, beta = kaiserord(ripple_db, width)
    
    N = N/order_scale
    N = int(N);

    # Use firwin with a Kaiser window to create a lowpass FIR filter.
    taps = firwin(N, cutoff_hz/nyq_rate, window=('kaiser', beta))
    
    print('Number of coefficients:', N)

    return [taps, N]

def designFIR_HP(sample_rate, width_hz, ripple_db, cutoff_hz, order_scale):

    # The Nyquist rate of the signal.
    nyq_rate = sample_rate / 2.0

    # The desired width of the transition from pass to stop,
    # relative to the Nyquist rate.  We'll design the filter
    # with a specific transition width.
    width = width_hz/nyq_rate

    # Compute the order and Kaiser parameter for the FIR filter.
    N, beta = kaiserord(ripple_db, width)
    
    N = N/order_scale
    N = int(N);
    
    # no even order for highpass FIR filters
    if(N % 2) == 0:
        N = N + 1

    # Use firwin with a Kaiser window to create a highpass FIR filter.
    taps = firwin(N, cutoff_hz/nyq_rate,  window=('kaiser', beta), pass_zero=False)
    
    print('Number of coefficients:', N)
    
    
    return [taps, N]

def designFIR_BP(sample_rate, ripple_db, cutoff1_hz, cutoff2_hz, order_scale):

    # The Nyquist rate of the signal.
    nyq_rate = sample_rate / 2.0

    # The desired width of the transition from pass to stop,
    # relative to the Nyquist rate.  We'll design the filter
    # with a specific transition width.
    width =  (cutoff2_hz - cutoff1_hz)/nyq_rate/10

    # Compute the order and Kaiser parameter for the FIR filter.
    N, beta = kaiserord(ripple_db, width)
    
    N = N/order_scale
    N = int(N);

    # The cutoff frequencies of the filter.
    f1 = cutoff1_hz/nyq_rate
    f2 = cutoff2_hz/nyq_rate
    taps = firwin(N, [f1, f2], window= 'blackmanharris', pass_zero=False)
    
    print('Number of coefficients:', N)

    return [taps, N]

def designFIR_BS(sample_rate, ripple_db, cutoff1_hz, cutoff2_hz, order_scale):

    # The Nyquist rate of the signal.
    nyq_rate = sample_rate / 2.0

    # The desired width of the transition from pass to stop,
    # relative to the Nyquist rate.  We'll design the filter
    # with a specific transition width.
    width =  (cutoff2_hz - cutoff1_hz)/nyq_rate/10

    # Compute the order and Kaiser parameter for the FIR filter.
    N, beta = kaiserord(ripple_db, width)
    
    N = N/order_scale
    N = int(N);
    
    # no even order for highpass FIR filters
    if(N % 2) == 0:
        N = N + 1

    # The cutoff frequencies of the filter.
    f1 = cutoff1_hz/nyq_rate
    f2 = cutoff2_hz/nyq_rate
    taps = firwin(N, [f1, f2], window= 'blackmanharris')
    
    print('Number of coefficients:', N)

    return [taps, N]

def print_params(filter_type, sample_rate, width_hz, ripple_db, cutoff1_hz, cutoff2_hz=0):
    print('Filter parameters:')
    print('##############################')
    if filter_type == 'single':
        print('Sample Rate (Hz):', sample_rate)
        print('Transition Bandwidth (Hz):', width_hz)
        print('Stopband Ripple (dB):', ripple_db)
        print('Cutoff Frequency (Hz):',  cutoff1_hz)
    else:
        print('Sample Rate (Hz):', sample_rate)
        print('Stopband Ripple (dB):', ripple_db)
        print('Transition Bandwidth (Hz):', width_hz)
        print('Low Band Frequency (Hz):',  cutoff1_hz)
        print('High Band Frequency (Hz):',  cutoff2_hz)
            

###########################################################
# POSSIBLE OPTIONS: Highpass, Lowpass, Bandpass, BandStop
###########################################################

print('Number of arguments:', len(sys.argv), 'arguments.')
print('Argument List:', str(sys.argv))
print(sys.argv)

if len(sys.argv) == 1:
    raise ValueError('not enough arguments, call HELP')

filter_type = str(sys.argv[1])

if len(sys.argv) == 2:
    command = str(sys.argv[1])
    if command == 'help':
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
        print('Lowpass Args : LP, sample rate, transition bandwidth, stopband ripple in dB, cutoff frequency in Hz', 'Order Reduction Scaling')
        print('Highpass Args: HP, sample rate, transition bandwidth, stopband ripple in dB, cutoff frequency in Hz', 'Order Reduction Scaling')
        print('Bandpass Args: BP, sample rate, stopband ripple in dB, cutoff frequency (low) in Hz, cutoff frequency (high) in Hz', 'Order Reduction Scaling')
        print('Bandpass Args: BS, sample rate, stopband ripple in dB, cutoff frequency (low) in Hz, cutoff frequency (high) in Hz', 'Order Reduction Scaling')
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
    
        sys.exit()

if len(sys.argv) < 7:
    order_scale = 1
else:
    order_scale = int(sys.argv[6])
 
if filter_type == 'LP':
    sample_rate = int(sys.argv[2])
    width_hz = int(sys.argv[3])
    ripple_db = int(sys.argv[4])
    cutoff_hz = int(sys.argv[5])
    [taps, Order] = designFIR_LP(sample_rate, width_hz, ripple_db, cutoff_hz, order_scale)
    
    nyq_rate = sample_rate/2.0
    print_params('single', sample_rate, width_hz, ripple_db, cutoff_hz)
    cutoff1_hz = cutoff_hz - width_hz/2
    cutoff2_hz = cutoff_hz + width_hz/2
    
elif filter_type == 'HP':
    sample_rate = int(sys.argv[2])
    width_hz = int(sys.argv[3])
    ripple_db = int(sys.argv[4])
    cutoff_hz = int(sys.argv[5])
    [taps, Order] = designFIR_HP(sample_rate, width_hz, ripple_db, cutoff_hz, order_scale)
    nyq_rate = sample_rate/2.0
    print_params('single', sample_rate, width_hz, ripple_db, cutoff_hz)
    cutoff1_hz = cutoff_hz - width_hz/2
    cutoff2_hz = cutoff_hz + width_hz/2
    
elif filter_type == 'BP':
    sample_rate = int(sys.argv[2])
    ripple_db = int(sys.argv[3])
    cutoff1_hz = int(sys.argv[4])
    cutoff2_hz = int(sys.argv[5])
    [taps, Order] = designFIR_BP(sample_rate,ripple_db, cutoff1_hz, cutoff2_hz, order_scale)
    nyq_rate = sample_rate/2.0
    width_hz = cutoff2_hz - cutoff1_hz
    print_params('double', sample_rate, width_hz, ripple_db, cutoff1_hz, cutoff2_hz)
    
elif filter_type == 'BS':
    sample_rate = int(sys.argv[2])
    ripple_db = int(sys.argv[3])
    cutoff1_hz = int(sys.argv[4])
    cutoff2_hz = int(sys.argv[5])
    [taps, Order] = designFIR_BS(sample_rate, ripple_db, cutoff1_hz, cutoff2_hz, order_scale)
    
    nyq_rate = sample_rate/2.0
    width_hz = cutoff2_hz - cutoff1_hz
    print_params('double', sample_rate, width_hz, ripple_db, cutoff1_hz, cutoff2_hz)
    
else:
    raise ValueError('no valid filter type defined')
    
mid_cutoff_hz = (cutoff1_hz + cutoff2_hz)/2
   
#------------------------------------------------
# Plot the magnitude response of the filter.
#------------------------------------------------
plt.figure()
w, h = freqz(taps, worN=8000)
#plt.subplot(211)
plt.grid(True)
plt.plot((w/pi)*nyq_rate, 20*log10(absolute(h)), linewidth=1, color='blue')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Gain (dB)')
plt.title('Magnitude Response, Order: %i' % Order)

# display parameters
ax = plt.gca()
xmin, xmax = ax.get_xbound()
ymin, ymax = ax.get_ybound()
l = mlines.Line2D([xmin,xmax], [-ripple_db,-ripple_db], linewidth=1, color='red')
ax.add_line(l)

left_cutoff = mlines.Line2D([cutoff1_hz,cutoff1_hz], [ymin,ymax], linewidth=1, color='green')
ax.add_line(left_cutoff)
right_cutoff = mlines.Line2D([cutoff2_hz,cutoff2_hz], [ymin,ymax], linewidth=1, color='green')
ax.add_line(right_cutoff)
mid_cutoff = mlines.Line2D([mid_cutoff_hz,mid_cutoff_hz], [ymin,ymax], linewidth=1, color='black')
ax.add_line(mid_cutoff)

# legend entries

plt.legend(['Magnitude Response in dB', 'custom set stopband ripple', 'frequency cutoff band', 'frequency cutoff band', 'mid frequency cutoff'], loc='best',prop={'size': 6})
plt.savefig('mag.png', dpi = 300)
plt.close()

plt.figure()
#plt.subplot(212)
angles = unwrap(angle(h))
plt.plot((w/pi)*nyq_rate,angles)
plt.ylabel('Phase (radians)')
plt.xlabel('Frequency (Hz)')
plt.title('Phase response, Order: %i' % Order)
plt.grid(True)
plt.subplots_adjust(hspace=0.5)
plt.savefig('phase.png', dpi = 300)

#Read image
im = Image.open('mag.png')
#Display image
im.show()