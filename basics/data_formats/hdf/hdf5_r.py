import h5py

f = h5py.File('file.h5','r')   # 打开h5文件  
f.keys()                       # 可以查看所有的主键  
a = f['labels'][:]             # 取出主键为data的所有的键值  
f.close()

print(a)
