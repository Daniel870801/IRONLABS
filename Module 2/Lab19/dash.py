# -*- coding: utf-8 -*-
"""
Created on Thu Mar 24 11:19:51 2022

@author: lenovo
"""
import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import load_breast_cancer

breast_cancer = load_breast_cancer(as_frame=True)
breast_cancer_df = pd.concat((breast_cancer["data"], breast_cancer["target"]), axis=1)
breast_cancer_df["target"] = [breast_cancer.target_names[val] for val in breast_cancer_df["target"]]

st.set_page_config(layout="wide")
st.markdown("Breast Cancer Stats")
st.write(breast_cancer_df)

choice=st.sidebar.selectbox('Mean Texture vs Mean Area', ['malignant','benign','both'])

scatter_fig = plt.figure(figsize=(8,7))

scatter_ax = scatter_fig.add_subplot(111)

malignant_df = breast_cancer_df[breast_cancer_df["target"] == "malignant"]
benign_df = breast_cancer_df[breast_cancer_df["target"] == "benign"]
if choice=='malignant':
    malignant_df.plot.scatter(x="mean texture", y="mean area", s=120, c="tomato", alpha=0.6, ax=scatter_ax, label="Malignant")
elif choice=='benign':
    benign_df.plot.scatter(x="mean texture", y="mean area", s=120, c="dodgerblue", alpha=0.6, ax=scatter_ax,
                       title="Mean Texture vs Mean Area", label="Benign");
else:
    malignant_df.plot.scatter(x="mean texture", y="mean area", s=120, c="tomato", alpha=0.6, ax=scatter_ax, label="Malignant")
    benign_df.plot.scatter(x="mean texture", y="mean area", s=120, c="dodgerblue", alpha=0.6, ax=scatter_ax,
                       title="Mean Texture vs Mean Area", label="Benign");

#st.pyplot(scatter_fig)
avg_breast_cancer_df=breast_cancer_df.groupby('target').agg('mean')

choice2=st.sidebar.multiselect("Average Measurements per Tumor Type", options=["mean radius", "mean texture", "mean perimeter", "area error"],default=["mean radius", "mean texture", "mean perimeter", "area error"])
bar_fig = plt.figure(figsize=(8,7))
bar_ax = bar_fig.add_subplot(111)

if choice2:  
    sub_avg_breast_cancer_df = avg_breast_cancer_df[choice2]
    sub_avg_breast_cancer_df.plot.bar(alpha=0.8, ax=bar_ax, title="Average Measurements per Tumor Type")

else:
    sub_avg_breast_cancer_df = avg_breast_cancer_df[["mean radius", "mean texture", "mean perimeter", "area error"]]
    sub_avg_breast_cancer_df.plot.bar(alpha=0.8, ax=bar_ax, title="Average Measurements per Tumor Type")


#st.pyplot(bar_fig)

choice3=st.sidebar.radio("Please choose", options=["mean radius", "mean texture","both"])
hist_fig = plt.figure(figsize=(8,7))
hist_ax = hist_fig.add_subplot(111)

if choice3 in ["mean radius","mean texture"]:
         sub_breast_cancer_df = breast_cancer_df[choice3]
         sub_breast_cancer_df.plot.hist(bins=50, alpha=0.7, ax=hist_ax, title="Average Measurements per Tumor Type")   
else:
        sub_breast_cancer_df = breast_cancer_df[["mean radius", "mean texture"]]
        sub_breast_cancer_df.plot.hist(bins=50, alpha=0.7, ax=hist_ax, title="Average Measurements per Tumor Type")

#st.pyplot(hist_fig)

measurements = breast_cancer_df.drop(labels=["target"], axis=1).columns.tolist()
st.sidebar.markdown("### Hexbin Chart: Explore Concentration of Measurements :")

hexbin_x_axis = st.sidebar.selectbox("Hexbin-X-Axis", measurements, index=0)
hexbin_y_axis = st.sidebar.selectbox("Hexbin-Y-Axis", measurements, index=1)

if hexbin_x_axis and hexbin_y_axis:
    hexbin_fig = plt.figure(figsize=(6,4))

    hexbin_ax = hexbin_fig.add_subplot(111)

    breast_cancer_df.plot.hexbin(x=hexbin_x_axis, y=hexbin_y_axis,
                                 reduce_C_function=np.mean,
                                 gridsize=25,
                                 #cmap="Greens",
                                 ax=hexbin_ax, title="Concentration of Measurements");
#st.pyplot(hexbin_fig)

container1 = st.container()
col1, col2 = st.columns(2)

with container1:
    with col1:
        scatter_fig
    with col2:
        bar_fig


container2 = st.container()
col3, col4 = st.columns(2)

with container2:
    with col3:
        hist_fig
    with col4:
        hexbin_fig
        

print(measurements)