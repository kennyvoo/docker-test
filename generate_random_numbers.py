import random
import matplotlib.pyplot as plt

rand_nums= [random.randint(1,10) for i in range(10)]
plt.plot(rand_nums)
plt.show()