# %% [markdown]
# # Indian Agriculture: Efficiency vs Scale (1966-2017)

# %% [markdown]
# Import Libraries

# %%
import pandas as pd
import numpy as np
import plotly.express as px
import matplotlib.pyplot as plt
import seaborn as sns

# %%
def plot_top_states(df, column_name, chart_title):
    # Step 1: Process the data
    top_df = df.groupby('State Name')[column_name].sum().sort_values(ascending=False).reset_index().head(10)
    
    # Step 2: Create the chart
    fig = px.bar(top_df, 
                 x='State Name', 
                 y=column_name, 
                 title=chart_title,
                 template='plotly_white')
    
    fig.update_layout(height=500, width=800)
    return fig.show(renderer="iframe")


# %% [markdown]
# <b><span style="color: #5F5F5F; background-color: #F2F4F2; padding: 20px; font-size: 18px; border-left: 8px solid #A9A9A9">📌 Loading the csv file</span></b>

# %%
df=pd.read_csv('/kaggle/input/indian-agriculture-dataset/ICRISAT-District Level Data.csv')

# %% [markdown]
# <b><span style="color: #5F5F5F; background-color: #F2F4F2; padding: 20px; font-size: 18px; border-left: 8px solid #A9A9A9">📌 Showing first five rows</span></b>

# %%
df.head()

# %%
# 1. First, ensure your main dataframe 'df' is loaded
# 2. Now, create 'andhra_df' by filtering for the state
andhra_df = df[df['State Name'] == 'Andhra Pradesh']

# 3. Double-check if it worked
print(f"✅ 'andhra_df' created successfully with {len(andhra_df)} records.")

# %%


# %% [markdown]
# ANDHRA PRADESH STATE AGRI_ANALYSIS

# %%
# 1. Filter for the State
andhra_df = df[df['State Name'] == 'Andhra Pradesh'].copy()

# 2. Filter for the District (Srikakulam)
srikakulam_df = andhra_df[andhra_df['Dist Name'] == 'Srikakulam'].copy()

# 3. Fact-Check: Did we get anything?
print(f"✅ Andhra Pradesh Records: {len(andhra_df)}")
print(f"✅ Srikakulam Records: {len(srikakulam_df)}")

# Preview the first few years of Srikakulam's data
srikakulam_df[['Year', 'RICE PRODUCTION (1000 tons)', 'RICE YIELD (Kg per ha)']].head()

# %% [markdown]
# SRIKAKULAM DISTRICT AGRI_ANALYSIS

# %%
import plotly.express as px

# We use the srikakulam_df directly
fig = px.line(
    srikakulam_df, 
    x='Year', 
    y='RICE YIELD (Kg per ha)',
    title='50-Year Rice Yield Trend: Srikakulam District',
    template='plotly_dark'
)

fig.update_layout(
    xaxis_title="Year (1966-2017)",
    yaxis_title="Yield (Kg per ha)",
    height=500
)

fig.show(renderer="iframe")

# %% [markdown]
# SRIKAKULAM VS EAST GODAVARI
# "YIELD GAP" between two districts

# %%
# Create a comparison dataframe
comp_df = andhra_df[andhra_df['Dist Name'].isin(['Srikakulam', 'East Godavari'])]

fig_comp = px.line(
    comp_df, 
    x='Year', 
    y='RICE YIELD (Kg per ha)', 
    color='Dist Name',
    title='The Yield Gap: Srikakulam vs East Godavari',
    template='plotly_dark'
)

fig_comp.show(renderer="iframe")

# %%
# --- STEP 1: Filter Data ---
andhra_df = df[df['State Name'] == 'Andhra Pradesh'].copy()
srikakulam_df = andhra_df[andhra_df['Dist Name'] == 'Srikakulam'].copy()
east_godavari_df = andhra_df[andhra_df['Dist Name'] == 'East Godavari'].copy()

# --- STEP 2: The Comparison Chart ---
import plotly.express as px

# Combine them for the chart
comparison_df = andhra_df[andhra_df['Dist Name'].isin(['Srikakulam', 'East Godavari'])]

fig = px.line(
    comparison_df, 
    x='Year', 
    y='RICE YIELD (Kg per ha)', 
    color='Dist Name',
    title='Productivity Gap: Srikakulam vs East Godavari (1966-2017)',
    template='plotly_dark'
)

fig.update_layout(
    xaxis_title="Year",
    yaxis_title="Rice Yield (Kg per ha)",
    legend_title="District"
)

fig.show(renderer="iframe")

# %%
df.tail()

# %% [markdown]
# <b><span style="color: #5F5F5F; background-color: #F2F4F2; padding: 20px; font-size: 18px; border-left: 8px solid #A9A9A9">📌 Dataset shape </span></b>

# %%
df.shape

# %% [markdown]
# <b><span style="color: #5F5F5F; background-color: #F2F4F2; padding: 20px; font-size: 18px; border-left: 8px solid #A9A9A9">📌 Total information of the dataset </span></b>

# %%
df.info()

# %% [markdown]
# <b><span style="color: #5F5F5F; background-color: #F2F4F2; padding: 20px; font-size: 18px; border-left: 8px solid #A9A9A9">📌 Checking null values </span></b>

# %%
df.isnull().sum()

# %% [markdown]
# <b><span style="color: #5F5F5F; background-color: #F2F4F2; padding: 20px; font-size: 18px; border-left: 8px solid #A9A9A9">📌 Checking duplicates </span></b>

# %%
df.duplicated().sum()

# %% [markdown]
# <b><span style="color: #5F5F5F; background-color: #F2F4F2; padding: 20px; font-size: 18px; border-left: 8px solid #A9A9A9">📌 Extra statistical measures </span></b>

# %%
df.describe()

# %% [markdown]
# <b><span style="color: #5F5F5F; background-color: #F2F4F2; padding: 20px; font-size: 18px; border-left: 8px solid #A9A9A9">📌 Showing all the columns </span></b>

# %%
df.columns

# %% [markdown]
# <div style="background-color: #088F8F; padding: 20px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
#     <h1 style="text-align: center; font-size: 36px; color: white; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3); margin-bottom: 10px;">Data Analysis and Visualization 📊</h1>
#     <p style="text-align: center; font-size: 18px; color: white;"></p>
# </div>

# %% [markdown]
# <div style="background-color: #AAD7D9; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Rice</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#AAD7D9; padding: 20px; font-size: 18px; border-left: 8px solid #FF9800">i) Rice production</span></b>

# %%
rice_state=df.groupby('State Name')['RICE PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

rice_state

# %%
fig=px.bar(rice_state, x='State Name', y='RICE PRODUCTION (1000 tons)',title='Top 10 rice productions by States',
          labels={'State Name':'State Name','Rice Production':'RICE PRODUCTION (1000 tons)'},
           color='RICE PRODUCTION (1000 tons)', color_continuous_scale='Viridis'
          )
fig.update_layout(xaxis_title='State names', yaxis_title='Rice Production')
fig.update_layout(height=600, width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#AAD7D9; padding: 20px; font-size: 18px; border-left: 8px solid #FF9800">ii) Rice Area</span></b>

# %%
rice_area=df.groupby('State Name')['RICE AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

rice_area

# %%
fig=px.line(rice_area, x='State Name', y='RICE AREA (1000 ha)',title='Top 10 rice production Areas by States',
          labels={'State Name':'State Name','Rice Area':'RICE AREA (1000 ha)'},
           color='RICE AREA (1000 ha)',
            line_shape="linear",
            markers=True
          )
fig.update_layout(xaxis_title='State names', yaxis_title='Rice Production')
fig.update_traces(marker=dict(size=20))
fig.update_layout(height=600, width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#AAD7D9; padding: 20px; font-size: 18px; border-left: 8px solid #FF9800">iii) By year</span></b>

# %%
rice_year=df.groupby('Year')['RICE PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

rice_year

# %%
fig = px.pie(rice_year, names='Year', values='RICE PRODUCTION (1000 tons)',
             title='Total Rice Production by 10 years',
             labels={'Year': 'Year', 'RICE PRODUCTION (1000 tons)': 'RICE PRODUCTION (1000 tons)'},
             color='Year', color_discrete_sequence=px.colors.sequential.Viridis,
             hole=0.1
             )
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#AAD7D9; padding: 20px; font-size: 18px; border-left: 8px solid #FF9800">iv) Rice yield</span></b>

# %%
rice_yield=df.groupby('State Name')['RICE YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

rice_yield

# %%
fig = px.bar(rice_yield, x='State Name', y='RICE YIELD (Kg per ha)',
             title='Total Rice yield by 10 states',
             labels={'State Name': 'State Name', 'RICE YIELD ': 'RICE YIELD (Kg per ha)'},
             color='RICE YIELD (Kg per ha)', color_continuous_scale='inferno'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Rice yield')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <div style="background-color: #F037A5; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Wheat</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#F037A5; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By production</span></b>

# %%
wheat_state=df.groupby('State Name')['WHEAT PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

wheat_state

# %%
fig = px.sunburst(wheat_state, path=['State Name'], values='WHEAT PRODUCTION (1000 tons)',
                  title='Total Wheat Production by 10 states',
                  color='WHEAT PRODUCTION (1000 tons)', color_continuous_scale=px.colors.sequential.Inferno,
                
                  )

fig.update_layout(height=600, width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#F037A5; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By area</span></b>

# %%
wheat_area=df.groupby('State Name')['WHEAT AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

wheat_area

# %%
fig = px.bar(wheat_area, x='State Name', y='WHEAT AREA (1000 ha)',
             title='Total Wheat Area by 10 states',
             labels={'State Name': 'State Name', 'WHEAT AREA ': 'WHEAT AREA (1000 ha)'},
             color='WHEAT AREA (1000 ha)', color_continuous_scale='sunset'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Wheat Area')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#F037A5; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
wheat_yield=df.groupby('State Name')['WHEAT YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

wheat_yield

# %%
fig = px.line(wheat_yield, x='State Name', y='WHEAT YIELD (Kg per ha)',
             title='Total Wheat yield by 10 states',
             labels={'State Name': 'State Name', 'WHEAT yield ': 'WHEAT YIELD (Kg per ha)'},
             color='WHEAT YIELD (Kg per ha)',
             line_shape="linear",
            markers=True,
            
             )

fig.update_layout(xaxis_title='State names', yaxis_title='Wheat Area')
fig.update_layout(template='gridon')
fig.update_traces(marker=dict(size=30))
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <div style="background-color: #F6B17A; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Barley</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#F6B17A; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
barley_area=df.groupby('State Name')['BARLEY AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

barley_area

# %%
fig = px.bar(barley_area, x='State Name', y='BARLEY AREA (1000 ha)',
             title='Total Barley Area by 10 states',
             labels={'State Name': 'State Name', 'BARLEY AREA ': 'BARLEY AREA (1000 ha)'},
             color='BARLEY AREA (1000 ha)', color_continuous_scale='icefire'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Barley Area')
fig.update_layout(template='gridon')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#F6B17A; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
barley_pro=df.groupby('State Name')['BARLEY PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

barley_pro

# %%
fig = px.scatter(
    barley_pro,
    x="State Name",
    y="BARLEY PRODUCTION (1000 tons)",
    size="BARLEY PRODUCTION (1000 tons)",  
    color="BARLEY PRODUCTION (1000 tons)",  
    title="Barley Production by 10 States",
    color_continuous_scale='Magma',
    size_max=40)

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Barley Production (1000 tons)",
    showlegend=True,  # Show legend if using color
)
fig.update_layout(template='gridon')
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#F6B17A; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
barley_yield=df.groupby('State Name')['BARLEY YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

barley_yield

# %%
fig = px.pie(barley_yield, names='State Name', values='BARLEY YIELD (Kg per ha)',
             title='Total Barley yield by 10 states',
             labels={'State Name': 'State Name', 'BARLEY YIELD (Kg per ha) ': 'BARLEY YIELD (Kg per ha)'},
             color_discrete_sequence=px.colors.sequential.Turbo
             )

fig.update_layout(xaxis_title='State names', yaxis_title='Barley yield')
fig.update_layout(height=600,width=800)
fig.update_layout(template='gridon')
fig.show()

# %% [markdown]
# <div style="background-color: #EA9085; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Sunflower</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#EA9085; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
sunflower_area=df.groupby('State Name')['SUNFLOWER AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

sunflower_area

# %%
fig = px.bar(sunflower_area, x='State Name', y='SUNFLOWER AREA (1000 ha)',
             title='Total Sunflower Area by 10 states',
             labels={'State Name': 'State Name', 'SUNFLOWER AREA (1000 ha) ': 'SUNFLOWER AREA (1000 ha)'},
             color='SUNFLOWER AREA (1000 ha)', color_continuous_scale='viridis'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Sunflower Area')

fig.update_layout(template='plotly_white')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#EA9085; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
sun_pro=df.groupby('State Name')['SUNFLOWER PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

sun_pro

# %%
fig = px.scatter(
    sun_pro,
    x="State Name",
    y="SUNFLOWER PRODUCTION (1000 tons)",
    size="SUNFLOWER PRODUCTION (1000 tons)",  
    color="SUNFLOWER PRODUCTION (1000 tons)",  
    title="Sunflower Production by 10 States",
    color_continuous_scale='Inferno',
    size_max=70)

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="SUNFLOWER PRODUCTION (1000 tons)",
    showlegend=True,  
)
fig.update_layout(template='plotly_white')
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#EA9085; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
sun_yield=df.groupby('State Name')['SUNFLOWER YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

sun_yield

# %%
fig = px.pie(sun_yield, names='State Name', values='SUNFLOWER YIELD (Kg per ha)',
                  title='Total Sunflower yield by 10 states',
                  color='State Name',color_discrete_sequence=px.colors.sequential.Burgyl 
                
                  )

fig.update_layout(height=600, width=800)
fig.update_layout(template='plotly_white')
fig.show()

# %% [markdown]
# <div style="background-color: #E0AED0; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Soyabean</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#E0AED0; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
soya_area=df.groupby('State Name')['SOYABEAN AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

soya_area

# %%
fig = px.bar(soya_area, x='State Name', y='SOYABEAN AREA (1000 ha)',
             title='Total Soyabean Area by 10 states',
             labels={'State Name': 'State Name', 'SOYABEAN AREA (1000 ha)) ': 'SOYABEAN AREA (1000 ha)'},
             color='SOYABEAN AREA (1000 ha)', color_continuous_scale='purpor'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Soyabean Area')

fig.update_layout(template='ggplot2')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#E0AED0; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
soya_pro=df.groupby('State Name')['SOYABEAN PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

soya_pro

# %%
fig = px.line(soya_pro, x='State Name', y='SOYABEAN PRODUCTION (1000 tons)',
             title='Total Soyabean yield by 10 states',
             labels={'State Name': 'State Name', 'SOYABEAN PRODUCTION (1000 tons) ': 'SOYABEAN PRODUCTION (1000 tons)'},
             color='SOYABEAN PRODUCTION (1000 tons)',
             line_shape="linear",
            markers=True
             )

fig.update_layout(xaxis_title='State names', yaxis_title='Soya Area')
fig.update_layout(template='ggplot2')
fig.update_layout(height=600,width=800)
fig.update_traces(marker=dict(size=20))
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#E0AED0; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
soya_yield=df.groupby('State Name')['SOYABEAN YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

soya_yield

# %%
fig = px.pie(soya_yield, names='State Name', values='SOYABEAN YIELD (Kg per ha)',
             title='Total Soyabean yield by 10 states',
             labels={'Year': 'Year', 'SOYABEAN YIELD (Kg per ha)': 'SOYABEAN YIELD (Kg per ha)'},
             color='SOYABEAN YIELD (Kg per ha)', color_discrete_sequence=px.colors.sequential.Oranges ,
             hole=0.05
             )

fig.update_layout(template='ggplot2')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <div style="background-color: #BED754; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Oilseeds</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#BED754; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
oil_area=df.groupby('State Name')['OILSEEDS AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

oil_area

# %%
fig = px.bar(oil_area, x='State Name', y='OILSEEDS AREA (1000 ha)',
             title='Total Oilseeds Area by 10 states',
             labels={'State Name': 'State Name', 'OILSEEDS AREA (1000 ha) ': 'OILSEEDS AREA (1000 ha)'},
             color='OILSEEDS AREA (1000 ha)', color_continuous_scale='blackbody'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Soyabean Area')

fig.update_layout(template='ggplot2')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#BED754; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
oil_pro=df.groupby('State Name')['OILSEEDS PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

oil_pro

# %%
fig = px.scatter(
    oil_pro,
    x="State Name",
    y="OILSEEDS PRODUCTION (1000 tons)",
    size="OILSEEDS PRODUCTION (1000 tons)",  
    color="OILSEEDS PRODUCTION (1000 tons)",  
    title="Oilseed Production by 10 States",
    color_continuous_scale='Sunset',
    size_max=40)

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Oilseed production (1000 tons)",
    showlegend=True,  
)
fig.update_layout(template='ggplot2')
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#BED754; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
oil_yield=df.groupby('State Name')['OILSEEDS YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

oil_yield

# %%
fig = px.pie(oil_yield, names='State Name', values='OILSEEDS YIELD (Kg per ha)',
             title='Total Soyabean yield by 10 states',
             labels={'State Name': 'State Name', 'OILSEEDS YIELD (Kg per ha)': 'OILSEEDS YIELD (Kg per ha)'},
             color='State Name', color_discrete_sequence=px.colors.sequential.Blackbody ,
             hole=0.1
             )

fig.update_layout(template='ggplot2')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <div style="background-color: #CD8D7B; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Cotton</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#CD8D7B; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
cotton_area=df.groupby('State Name')['COTTON AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

cotton_area

# %%
fig = px.bar(cotton_area, x='State Name', y='COTTON AREA (1000 ha)',
             title='Total Cotton Area by Top 10 states',
             labels={'State Name': 'State Name', 'COTTON AREA (1000 ha) ': 'COTTON AREA (1000 ha)'},
             color='COTTON AREA (1000 ha)', color_continuous_scale='inferno'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Cotton Area')

fig.update_layout(template='simple_white')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#CD8D7B; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
cot_pro=df.groupby('State Name')['COTTON PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)
cot_pro

# %%
fig = px.scatter(
    cot_pro,
    x="State Name",
    y="COTTON PRODUCTION (1000 tons)",
    size="COTTON PRODUCTION (1000 tons)",  
    color="COTTON PRODUCTION (1000 tons)",  
    title="Cotton Production by top 10 States",
    color_continuous_scale='Blackbody',
    size_max=40)

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Cotton production (1000 tons)",
    showlegend=True,  
)
fig.update_layout(template='simple_white')
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#CD8D7B; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
cotton_yield=df.groupby('State Name')['COTTON YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

cotton_yield

# %%
fig = px.sunburst(cotton_yield, path=['State Name'], values='COTTON YIELD (Kg per ha)',
                  title='Total Cotton Yield by top 10 states',
                  color='COTTON YIELD (Kg per ha)', color_continuous_scale=px.colors.sequential.Blackbody,
                
                  )

fig.update_layout(height=600, width=800)
fig.show()

# %% [markdown]
# <div style="background-color: #A1EEBD; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Fruits</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#A1EEBD; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
fruit_area=df.groupby('State Name')['FRUITS AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

fruit_area

# %%
fig = px.bar(fruit_area, x='State Name', y='FRUITS AREA (1000 ha)',
             title='Total Fruits Area by Top 10 states',
             labels={'State Name': 'State Name', 'FRUITS AREA (1000 ha) ': 'FRUITS AREA (1000 ha)'},
             color='FRUITS AREA (1000 ha)', color_continuous_scale='rainbow'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Fruit Area')

fig.update_layout(template='plotly_dark')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <div style="background-color: #A1EEBD; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Vegetables</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#A1EEBD; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
vege_area=df.groupby('State Name')['VEGETABLES AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

vege_area

# %%
fig = px.pie(vege_area, names='State Name', values='VEGETABLES AREA (1000 ha)',
                  title='Total Vegetable Area by top 10 states',
                  color='VEGETABLES AREA (1000 ha)', color_discrete_sequence=px.colors.sequential.Agsunset
                
                  )

fig.update_layout(height=600, width=800)
fig.update_layout(template='plotly_dark')
fig.show()

# %% [markdown]
# <div style="background-color: #A1EEBD; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Fruits and Vegetables</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#A1EEBD; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
f_v=df.groupby('State Name')['FRUITS AND VEGETABLES AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

f_v

# %%
fig = px.line(f_v, x='State Name', y='FRUITS AND VEGETABLES AREA (1000 ha)',
             title='Total Fruits and Vegetable areas by Top 10 states',
             labels={'State Name': 'State Name', 'FRUITS AND VEGETABLES AREA (1000 ha) ': 'FRUITS AND VEGETABLES AREA (1000 ha)'},
             color='FRUITS AND VEGETABLES AREA (1000 ha)',
             line_shape="linear",
            markers=True
             )

fig.update_layout(xaxis_title='State names', yaxis_title='Fruits and Vegetables Area')
fig.update_layout(template='plotly_dark')
fig.update_layout(height=600,width=800)
fig.update_traces(marker=dict(size=16))
fig.show()

# %% [markdown]
# <div style="background-color: #F6F7C4; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Potatoes</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#F6F7C4; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %% [markdown]
# 

# %%
pota_area=df.groupby('State Name')['POTATOES AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

pota_area

# %%
fig = px.bar(pota_area, x='State Name', y='POTATOES AREA (1000 ha)',
             title='Total Potatoes Area by Top 10 states',
             labels={'State Name': 'State Name', 'POTATOES AREA (1000 ha) ': 'POTATOES AREA (1000 ha)'},
             color='POTATOES AREA (1000 ha)', color_continuous_scale='haline'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Potatoes Area')

fig.update_layout(template='plotly_white')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <div style="background-color: #F6F7C4; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Onions</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#F6F7C4; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
oni_area=df.groupby('State Name')['ONION AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

oni_area

# %%
fig = px.pie(oni_area, names='State Name', values='ONION AREA (1000 ha)',
             title='Total Onions Area by top 10 states',
             labels={'State Name': 'State Name', 'ONION AREA (1000 ha)': 'ONION AREA (1000 ha)'},
             color='ONION AREA (1000 ha)', color_discrete_sequence=px.colors.sequential.Magenta ,
             )

fig.update_layout(template='plotly_white')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <div style="background-color: #F6F7C4; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Fodder</p>
# </div>

# %% [markdown]
# Fodder includes hay, straw, silage, compressed and pelleted feeds, oils and mixed rations, and sprouted grains and legumes (such as bean sprouts, fresh malt, or spent malt). Most animal feed is from plants, but some manufacturers add ingredients to processed feeds that are of animal origin.

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#F6F7C4; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
fodd_area=df.groupby('State Name')['FODDER AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

fodd_area

# %%
fig = px.scatter(
    fodd_area,
    x="State Name",
    y="FODDER AREA (1000 ha)",
    size="FODDER AREA (1000 ha)",  
    color="FODDER AREA (1000 ha)",  
    title="Fodder Area by top 10 States",
    size_max=50,
color_continuous_scale='Tealgrn')

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Fodder areas",
    showlegend=True,  
)
fig.update_layout(template='gridon')
fig.show()

# %% [markdown]
# <div style="background-color: #A1EEBD; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Kharif Sorghum</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#A1EEBD; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
kh_area=df.groupby('State Name')['KHARIF SORGHUM AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

kh_area

# %%
fig = px.bar(kh_area, x='State Name', y='KHARIF SORGHUM AREA (1000 ha)',
             title='Total Kharif Sorghum Area by Top 10 states',
             labels={'State Name': 'State Name', 'KHARIF SORGHUM AREA (1000 ha) ': 'KHARIF SORGHUM AREA (1000 ha)'},
             color='KHARIF SORGHUM AREA (1000 ha)'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Kharif Sorghum  Area')

fig.update_layout(template='seaborn')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#A1EEBD; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
kh_pro=df.groupby('State Name')['KHARIF SORGHUM PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

kh_pro

# %%
fig = px.pie(kh_pro, names='State Name', values='KHARIF SORGHUM PRODUCTION (1000 tons)',
             title='Total Kharif Sorghum production by top 10 states',
             labels={'State Name': 'State Name', 'KHARIF SORGHUM PRODUCTION (1000 tons)': 'KHARIF SORGHUM PRODUCTION (1000 tons)'},
             color='KHARIF SORGHUM PRODUCTION (1000 tons)', 
            hole=0.1
            )

fig.update_layout(template='plotly_white')
fig.update_layout(template='seaborn')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#A1EEBD; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
kh_y=df.groupby('State Name')['KHARIF SORGHUM YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

kh_y

# %%
fig = px.scatter(
    kh_y,
    x="State Name",
    y="KHARIF SORGHUM YIELD (Kg per ha)",
    size="KHARIF SORGHUM YIELD (Kg per ha)",  
    color="KHARIF SORGHUM YIELD (Kg per ha)",  
    title="KHARIF SORGHUM YIELD (Kg per ha)",
    size_max=50,
color_continuous_scale='Inferno')

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Kharif Sorghum yield",
    showlegend=True,  
)
fig.update_layout(template='seaborn')
fig.show()

# %% [markdown]
# <div style="background-color: #DF826C; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Rabi Sorghum</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#DF826C; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
rabi_area=df.groupby('State Name')['RABI SORGHUM AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

rabi_area

# %%
fig = px.bar(rabi_area, x='State Name', y='RABI SORGHUM AREA (1000 ha)',
             title='Total Rabi Sorghum Area by Top 10 states',
             labels={'State Name': 'State Name', 'RABI SORGHUM AREA (1000 ha) ': 'RABI SORGHUM AREA (1000 ha)'},
             color='RABI SORGHUM AREA (1000 ha)', color_continuous_scale='magma'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Rabi Sorghum  Area')

fig.update_layout(template='plotly_white')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#DF826C; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
rabi_pro=df.groupby('State Name')['RABI SORGHUM PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

rabi_pro

# %%
fig = px.pie(rabi_pro, names='State Name', values='RABI SORGHUM PRODUCTION (1000 tons)',
             title='Total Rabi Sorghum production by top 10 states',
             labels={'State Name': 'State Name', 'RABI SORGHUM PRODUCTION (1000 tons)': 'RABI SORGHUM PRODUCTION (1000 tons)'},
             color='RABI SORGHUM PRODUCTION (1000 tons)',color_discrete_sequence=px.colors.sequential.Magma 
            )

fig.update_layout(template='plotly_white')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#DF826C; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
rabi_yield=df.groupby('State Name')['RABI SORGHUM YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

rabi_yield

# %%
fig = px.scatter(
    rabi_yield,
    x="State Name",
    y="RABI SORGHUM YIELD (Kg per ha)",
    size="RABI SORGHUM YIELD (Kg per ha)",  
    color="RABI SORGHUM YIELD (Kg per ha)",  
    title="Rabi Sorghum Yield by top 10 states",
    size_max=30,
color_continuous_scale='Sunset')

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Rabi Sorghum yield",
    showlegend=True,  
)
fig.update_layout(template='plotly_white')
fig.show()

# %% [markdown]
# <div style="background-color: #8ADAB2; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Maize</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#8ADAB2; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
maize_ar=df.groupby('State Name')['MAIZE AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

maize_ar

# %%
fig = px.bar(maize_ar, x='State Name', y='MAIZE AREA (1000 ha)',
             title='Total Maize Area by Top 10 states',
             labels={'State Name': 'State Name', 'MAIZE AREA (1000 ha) ': 'MAIZE AREA (1000 ha)'},
             color='MAIZE AREA (1000 ha)', color_continuous_scale='sunset'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Maize  Area')

fig.update_layout(template='ggplot2')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#8ADAB2; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
maize_pro=df.groupby('State Name')['MAIZE PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

maize_pro

# %%
fig = px.pie(maize_pro, names='State Name', values='MAIZE PRODUCTION (1000 tons)',
             title='Total Maize production by top 10 states',
             labels={'State Name': 'State Name', 'MAIZE PRODUCTION (1000 tons)': 'MAIZE PRODUCTION (1000 tons)'},
             color='MAIZE PRODUCTION (1000 tons)',
             hole=0.1
             #color_discrete_sequence=px.colors.sequential.Sunset
            )

fig.update_layout(template='plotly_dark')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#8ADAB2; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
maize_yield=df.groupby('State Name')['MAIZE YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

maize_yield

# %%
import plotly.express as px

fig = px.scatter(
    maize_yield,
    x="State Name",
    y="MAIZE YIELD (Kg per ha)",
    size="MAIZE YIELD (Kg per ha)",
    color="MAIZE YIELD (Kg per ha)",
    title="MAIZE YIELD (Kg per ha)",
    size_max=30,
    color_continuous_scale='Viridis'  # Specify the color scale
)

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Maize yield",
    showlegend=True,
)
fig.update_layout(template='plotly_dark')
fig.show()

# %% [markdown]
# <div style="background-color: #E6A4B4; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Finger Millet</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#E6A4B4; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
fg_area=df.groupby('State Name')['FINGER MILLET AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

fg_area

# %%
fig = px.bar(fg_area, x='State Name', y='FINGER MILLET AREA (1000 ha)',
             title='Total Finger Millet Area by Top 10 states',
             labels={'State Name': 'State Name', 'FINGER MILLET AREA (1000 ha) ': 'FINGER MILLET AREA (1000 ha)'},
             color='FINGER MILLET AREA (1000 ha)', color_continuous_scale='blackbody'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Finger Millet Area')

fig.update_layout(template='seaborn')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#E6A4B4; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
fg_pro=df.groupby('State Name')['FINGER MILLET PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

fg_pro

# %%
fig = px.pie(fg_pro, names='State Name', values='FINGER MILLET PRODUCTION (1000 tons)',
             title='Total Finger Millet production by top 10 states',
             labels={'State Name': 'State Name', 'FINGER MILLET PRODUCTION (1000 tons)': 'FINGER MILLET PRODUCTION (1000 tons)'},
             color='FINGER MILLET PRODUCTION (1000 tons)',
             hole=0.1,
             color_discrete_sequence=px.colors.sequential.Plasma
            )

fig.update_layout(template='seaborn')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#E6A4B4; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
fg_yi=df.groupby('State Name')['FINGER MILLET YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

fg_yi

# %%
fig = px.scatter(
    fg_yi,
    x="State Name",
    y="FINGER MILLET YIELD (Kg per ha)",
    size="FINGER MILLET YIELD (Kg per ha)",
    color="FINGER MILLET YIELD (Kg per ha)",
    title="Finger Millet yield by top 10 states",
    size_max=30,
    color_continuous_scale='Magma' 
)

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Finger Millet yield",
    showlegend=True,
)
fig.update_layout(template='seaborn')
fig.show()

# %% [markdown]
# <div style="background-color: #9BB8CD; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Safflower</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#9BB8CD; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
saff_ar=df.groupby('State Name')['SAFFLOWER AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

saff_ar

# %%
fig = px.bar(saff_ar, x='State Name', y='SAFFLOWER AREA (1000 ha)',
             title='Total Safflower Area by Top 10 states',
             labels={'State Name': 'State Name', 'SAFFLOWER AREA (1000 ha) ': 'SAFFLOWER AREA (1000 ha)'},
             color='SAFFLOWER AREA (1000 ha)', color_continuous_scale='aggrnyl'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Safflower Area')

fig.update_layout(template='simple_white')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#9BB8CD; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
saff_pro=df.groupby('State Name')['SAFFLOWER PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

saff_pro

# %%
fig = px.pie(
    saff_pro,
    names='State Name',
    values='SAFFLOWER PRODUCTION (1000 tons)',
    title='Total Safflower production by top 10 states',
    labels={'State Name': 'State Name', 'SAFFLOWER PRODUCTION (1000 tons)': 'SAFFLOWER PRODUCTION (1000 tons)'},
    color='SAFFLOWER PRODUCTION (1000 tons)'
)
# Manually adjust the pull to make all slices fully visible
fig.update_traces(pull=[0] * len(saff_pro), textinfo='value+percent', textposition='inside')

fig.update_layout(template='simple_white')
fig.update_layout(height=600, width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#9BB8CD; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
saff_yi=df.groupby('State Name')['SAFFLOWER YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

saff_yi

# %%
fig = px.scatter(
    saff_yi,
    x="State Name",
    y="SAFFLOWER YIELD (Kg per ha)",
    size="SAFFLOWER YIELD (Kg per ha)",
    color="SAFFLOWER YIELD (Kg per ha)",
    title="Safflower yield by top 10 states",
    size_max=30,
    color_continuous_scale='Tealgrn' 
)

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Finger Millet yield",
    showlegend=True,
)
fig.update_layout(template='simple_white')
fig.show()

# %% [markdown]
# <div style="background-color:  #FFF8C9; #padding: 20px; border-radius: 20px;">
#     <p style="font-size: 40px; font-family: 'Verdana'; color: #3A405A; text-align: center;">Sugercane</p>
# </div>

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#FFF8C9; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">i) By area</span></b>

# %%
sug_ar=df.groupby('State Name')['SUGARCANE AREA (1000 ha)'].sum().sort_values(ascending=False).reset_index().head(10)

sug_ar

# %%
fig = px.bar(sug_ar, x='State Name', y='SUGARCANE AREA (1000 ha)',
             title='Total Sugercane Area by Top 10 states',
             labels={'State Name': 'State Name', 'SUGARCANE AREA (1000 ha) ': 'SUGARCANE AREA (1000 ha)'},
             color='SUGARCANE AREA (1000 ha)', color_continuous_scale='rainbow'
          )

fig.update_layout(xaxis_title='State names', yaxis_title='Sugercane Area')

fig.update_layout(template='ggplot2')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#FFF8C9; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">ii) By production</span></b>

# %%
sug_pro=df.groupby('State Name')['SUGARCANE PRODUCTION (1000 tons)'].sum().sort_values(ascending=False).reset_index().head(10)

sug_pro

# %%
fig = px.pie(sug_pro, names='State Name', values='SUGARCANE PRODUCTION (1000 tons)',
             title='Total Sugercane production by top 10 states',
             labels={'State Name': 'State Name', 'SUGARCANE PRODUCTION (1000 tons)': 'SUGARCANE PRODUCTION (1000 tons)'},
             color='SUGARCANE PRODUCTION (1000 tons)',
             hole=0.1,
             color_discrete_sequence=px.colors.sequential.Blackbody
            )

fig.update_layout(template='ggplot2')
fig.update_layout(height=600,width=800)
fig.show()

# %% [markdown]
# <b><span style="color: #3C0753; background-color:#FFF8C9; padding: 20px; font-size: 18px; border-left: 8px solid F037A5">iii) By yield</span></b>

# %%
sug_yi=df.groupby('State Name')['SUGARCANE YIELD (Kg per ha)'].sum().sort_values(ascending=False).reset_index().head(10)

sug_yi

# %%
fig = px.scatter(
    sug_yi,
    x="State Name",
    y="SUGARCANE YIELD (Kg per ha)",
    size="SUGARCANE YIELD (Kg per ha)",
    color="SUGARCANE YIELD (Kg per ha)",
    title="Sugarcane yield by top 10 states",
    size_max=30,
     
)

fig.update_layout(
    height=600,
    width=800,
    xaxis_title="State Name",
    yaxis_title="Finger Millet yield",
    showlegend=True,
)
fig.update_layout(template='ggplot2')
fig.show()

# %% [markdown]
# <div style="background-color: #F2F3F4; padding: 20px; border-radius: 10px;">
#     <p style="font-size: 24px; font-family: 'Verdana'; color: #3A405A; text-align: center;">
# Thank you for exploring my notebook!</p>
# </div>


