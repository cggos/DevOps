import h5py  #导入第三方库
import numpy as np  

imgData = np.zeros((30,3,128,256))  
f = h5py.File('file.h5','w')        # 创建一个h5文件，文件指针是f  
f['data'] = imgData                 # 将数据写入文件的主键data下面  
f['labels'] = range(100)            # 将数据写入文件的主键labels下面  
f.close()                           # 关闭文件 
