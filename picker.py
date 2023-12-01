import random
import time

random.seed(time.process_time())
with open("languages.txt") as f:
    options = f.readlines()
    choice = "Day"
    while "Day" in choice:
        choice = random.choice(options)
    print(choice)
