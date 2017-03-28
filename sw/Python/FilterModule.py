# -*- coding: utf-8 -*-
"""
Created on Tue Mar 28 08:02:35 2017

@author: Martin
"""

#-----------------------------------------------------
#defines for flexible filter function
#
#following filter types can be selected:
#-> Butterworth
#-> Bessel
#-> Bandpass
#-> Bandtop
#-> Nyquist
#
#Frequencies have to be speciefied
#-----------------------------------------------------

import scipy.signal as sig
import numpy as np
import matplotlib.pyplot as plt

from enum import Enum

class FilterType(Enum):
    BUTTER = 1
    BESSEL = 2
    BPASS  = 3
    BSTOP  = 4
    NYQU   = 5
    
    
SampleRate = 48000;     #default sample rate for DAT recorders
    
def butter(Order, PassFrequency, StopFrequency):
    
    #calc Nyquist Frequency
    Nyquist = SampleRate*0.5;
    
    if PassFrequency > StopFrequency : 
        b, a = sig.butter(Order, PassFrequency/Nyquist,'high', analog=False);
        print(b);
        
    if PassFrequency < StopFrequency : 
        b, a = sig.butter(Order, PassFrequency/Nyquist,'low', analog=False);
        print(b);
                  
    #write to file
    text_file = open("Coefficients.txt", "w")         
    i = 0 
    while(i < len(b)):
        text_file.write("%f %f\n" % (b[i], b[i+1]))
        i = i+2

    text_file.close()
    
def bessel(Order, PassFrequency, StopFrequency):
    print('not implemented yet')
    
def bandpass(Order, PassFrequency, StopFrequency):
    print('not implemented yet')
    
def bandstop(Order, PassFrequency, StopFrequency): 
    print('not implemented yet')
    
def nyquist(Order, PassFrequency, StopFrequency):
    print('not implemented yet')
    
def coeff_plot(Coefficients):
    
    ####################################################
    #plot filter magnitude and frequency response
    ####################################################
    w, h = sig.freqz(Coefficients)

    fig = plt.figure()
    plt.title('Digital filter frequency response')
    ax1 = fig.add_subplot(111)

    plt.plot(w, 20 * np.log10(abs(h)), 'b')
    plt.ylabel('Amplitude [dB]', color='b')
    plt.xlabel('Frequency [rad/sample]')

    ax2 = ax1.twinx()
    angles = np.unwrap(np.angle(h))
    plt.plot(w, angles, 'g')
    plt.ylabel('Angle (radians)', color='g')
    plt.grid()
    plt.axis('tight')
    plt.show()

def DesignFilter(Type, Order, PassFrequency, StopFrequency):

    # map the inputs to the function blocks
    options = {
        1 : butter,
        2 : bessel,
        3 : bandpass,
        4 : bandstop,
        5 : nyquist
    }
    
    options[Type](Order, PassFrequency, StopFrequency);
    