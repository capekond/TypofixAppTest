import pandas as pd

res = pd.DataFrame({
    'name':['john','david','anna'],
    'country':['USA','UK',"EU"]
}).query("country == 'USA'")
print(res['name'].values[0])

res1 = pd.read_csv('C:\\Users\\ocape\\IdeaProjects\\TypofixAppTest\\tests\\resources\\test_data\\references\\_list.csv', sep=';')
res2 = res1.query("language == 'Croatian'")
print(res2['name'].values[0])