# plot the average timeseries


# the script should take a list of txt files representing timeseries of a group of subjects (aka A or B)
# the script should return a plot with the average timesreis with +/- SEM shading
# the script should have a fixed y limit
# y title should be "% BOLD change"
# time (Sec)

# second modification is pass only the frequency and genotype and the script does the rest

def plot_av_percent_change(frequency, genotype):

    import os
    import re
    import numpy as np
    import matplotlib.pyplot as plt
    from scipy import stats
    import ntpath
    import pandas as pd

    directory = '/media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3/{0}/timeseries'.format(
        frequency)
    os.chdir(directory)

# get all the names from the given directory
    filenames = list(os.listdir(directory))
    list_of_ts = []

# use only the files belongs to the specific genotype
    for file in filenames:
        if file[0] == genotype:
            list_of_ts.append(file)

    list_ts_arrays = []
    i = 0

    for ts in list_of_ts:
        while i < len(list_of_ts):
            ts = np.loadtxt(list_of_ts[i])
            list_ts_arrays.append(ts)
            i = i + 1

    mean_ts = np.mean(list_ts_arrays, axis=0)
    mean_ts_df = pd.DataFrame(mean_ts)

    # smoothing for the signal
    smooth_mean = mean_ts_df.rolling(5).mean()
    # remove NaN
    smooth_mean = smooth_mean.fillna(smooth_mean.mean())
    smooth_mean = smooth_mean.rename(columns={0: 'timeseries'})
    # I want to make the x by sec (0:300) rather than by volumes (0:15)
    time = np.arange(0, 300, 2)

    # add another column to smooth_mean to serve as x axis time
    smooth_mean['time'] = time

    sem_ts = stats.sem(list_ts_arrays, axis=0)  # sem as in standard error of the mean

    # mean plus or minus SEM
    under_line = smooth_mean['timeseries'] - sem_ts
    over_line = smooth_mean['timeseries'] + sem_ts

    # you need an index as the 1st arg of fill_between to determine where to put the shading
    filling_index = list(range(0, 150))

    # TODO Do not forget to put the stimulation protocol # DONE
    # TODO one HRF

###############################################################################################################################
    # Sanity check
    genotype_from_list = ntpath.basename(list_of_ts[0])[0]
    frequency_from_list = re.search('change_(.+?)_', list_of_ts[0])
    frequency_from_list = frequency_from_list.group(1)

    if genotype == genotype_from_list and frequency == frequency_from_list:
        print('########################correct###################')
    else:
        print('##########ERROR##########')
###############################################################################################################################
# the stimulation file has changed. instead of 1 in place of stimulation, 0.8125(end range of y) was put

    stim = np.loadtxt(
        '/media/amr/Amr_4TB/Dropbox/thesis/stimulation/Stimulation.txt')

    ax = plt.axes()
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)

    plt.xticks(fontsize=14)
    plt.yticks(fontsize=14)
    # plt.yticks(y_range)
    plt.ylim(0.80125, 0.8125)
    plt.xlim(0, 298)
    plt.xlabel("Time (sec)", fontsize=18, fontname='Arial')
    plt.ylabel("% BOLD change", fontsize=18, fontname='Arial')

    if genotype == 'A':
        # create a figure of A group timeseries with sem shading over the stimulation pattern
        plt.plot(stim[:, 1], drawstyle='steps-pre', color='black', linewidth=0)
        plt.fill_between(stim[:,0], stim[:, 1], step="pre", alpha=0.2, color='gray')

        plt.plot(smooth_mean['time'], smooth_mean['timeseries'], color='#e41a1c99', linewidth=1)
        plt.fill_between(smooth_mean['time'], under_line, over_line, color='#e41a1c99', alpha=.3, linewidth=1)

    elif genotype == 'B':
        # create a figure of B group timeseries with sem shading over the stimulation pattern
        plt.plot(stim[:, 1], drawstyle='steps-pre', color='black', linewidth=0)
        plt.fill_between(stim[:,0], stim[:, 1], step="pre", alpha=0.2, color='gray')

        plt.plot(smooth_mean['time'], smooth_mean['timeseries'], color='#377eb899', linewidth=1)
        plt.fill_between(smooth_mean['time'], under_line, over_line, color='#377eb899', alpha=.3, linewidth=1)

    plt.savefig(
        "/media/amr/Amr_4TB/Dropbox/thesis/stimulation/CA3_{0}_{1}_%_change_ts.svg".format(genotype, frequency), format='svg')
    plt.close()


plot_av_percent_change('05Hz', 'A')
plot_av_percent_change('05Hz', 'B')


plot_av_percent_change('10Hz', 'A')
plot_av_percent_change('10Hz', 'B')


plot_av_percent_change('20Hz', 'A')
plot_av_percent_change('20Hz', 'B')


plot_av_percent_change('40Hz', 'A')
plot_av_percent_change('40Hz', 'B')
