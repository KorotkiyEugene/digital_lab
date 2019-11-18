stp_file_name = '../hw/signaltap_main.stp';
NFFT = 4096;
Fs = 500e3;
offset = 1025;

alt_signaltap_run('END_CONNECTION'); 

spectrum_analyzer = dsp.SpectrumAnalyzer(1, 'SampleRate', Fs, 'ShowLegend',true, 'Window', 'Blackman-Harris',...
     'FrequencyResolutionMethod', 'WindowLength', 'WindowLength', NFFT, 'YLimits', [-50, 140], 'SpectralAverages', 1, ....
     'ShowLegend', true, 'ChannelNames', {'CH0 Spectrum'}, 'ShowGrid', true, 'PlotAsTwoSidedSpectrum', true);
 
while(1)
 
    data = int16(alt_signaltap_run(stp_file_name, 'signed'));
    
    spectrum_analyzer(data(offset:offset+NFFT, 1));
    
    pause(0.2);
     
end



