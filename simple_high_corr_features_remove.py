from statsmodels.stats.outliers_influence import variance_inflation_factor 
import pandas as pd
import numpy as np

np.random.seed(42)
df = pd.DataFrame(np.random.rand(10, 5), columns=['A', 'B', 'C', 'D', 'E'])

corr_matrix = df.corr()

triu = corr_matrix.where( np.triu(np.ones(corr_matrix.shape), k = 1).astype(bool))
print(triu)
threshold = 0.15

drop_columns  = [columns for columns in triu.columns if any(triu[columns] > threshold)]

print(drop_columns)
df = df.drop(columns = drop_columns,axis = 1)



from statsmodels.stats.outliers_influence import variance_inflation_factor 
vif  = pd.DataFrame()
vif['columns'] = df.columns 
vif['vif'] = [variance_inflation_factor(df.values, i) for i in range(df.shape[1])]
print(vif['vif'])
