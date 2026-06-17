#After not in excel
t0 = "nar.&nbsp;12. 1. 2001"

#REAL:
t1 = 'nar.\u200912. 1. 2001'
t2 = 'nar. 12. 1. 2001'

t = t0.replace("&nbsp;", "\u2009")

print(t)
print(t == t1)
print(t == t2)



import openpyxl
from openpyxl.cell.text import InlineFont
from openpyxl.cell.rich_text import TextBlock, CellRichText

red = InlineFont(color='00FF0000')
green = InlineFont(color='00008000')
print(red == green)