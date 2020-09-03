import numpy as np
import pandas as pd
from datetime import datetime, timedelta
from matplotlib import pyplot as plt
from matplotlib import dates as mpl_dates


def histogram_plot(df, *xlabels, xlim = None, imgpath = None):
    fig, axs = plt.subplots(figsize = (10, 7), sharey = True, tight_layout = True)
    for xlabel in xlabels:
        df[xlabel].plot(kind = "hist", bins = 20, color = "steelblue", edgecolor = "black", density = True, label = "Histogram")
        df[xlabel].plot(kind = "kde", color = "red", label = "KDE")
        plt.xlabel("%s" % xlabel)
        plt.ylabel("Count")
        plt.title("%s Histogram" % xlabel)
    if xlim:
        plt.xlim(xlim[0], xlim[1])
    plt.legend()
    if imgpath:
        plt.savefig(imgpath)
    plt.show()


def timeseries_plot(df, xlabel, *ylabels, imgpath = None):
    fig, axs = plt.subplots(figsize = (30, 7), sharey = True, tight_layout = True)
    for ylabel in ylabels:
        plt.plot_date(df[xlabel], df[ylabel], linestyle = "solid", label = ylabel)
    plt.gcf().autofmt_xdate()
    date_format = mpl_dates.DateFormatter("%Y-%B-%d")
    plt.gca().xaxis.set_major_formatter(date_format)
    plt.title(ylabel)
    plt.xlabel("Date")
    plt.ylabel(ylabel)
    plt.legend()
    if imgpath:
        fig.save(imgpath)
    plt.show()


def scatter_plot(df, xlabel, *ylabels, imgpath = None):
    fig, axs = plt.subplots(figsize = (10, 7), sharey = True, tight_layout = True)
    for ylabel in ylabels:
        plt.scatter(df[xlabel], df[ylabel], label = ylabel)
    plt.title("%s VS %s" % (xlabel, ylabel))
    plt.xlabel("%s" % xlabel)
    plt.ylabel("%s" % ylabel)
    plt.legend()
    if imgpath:
        plt.savefig(imgpath)
    plt.show()


def bar_plot():
    pass




