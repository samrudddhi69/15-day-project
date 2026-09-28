# Loops
# for , while

# for
for i in range(1, 6):
    print(i)

# loop through a list
names = ["Samruddhi", "A", "B"]
for n in names:
    print(n)

# while:
i = 1
while i <= 5:
    print(i)
    i += 1

# break:
for i in range(1,10):
    if i == 5:
        break
    print(i)

# continue:
for i in range(1,10) :
    if i == 5:
        continue
    print(i)

# exmaple : sum 1 to 100:
total = 0
for i in range(1,101):
    total += i
print(total)

# PASS
for i in range(1, 6):

    if i == 3:
        pass

    print(i)

#  SUM USING FOR LOOP
total = 0
for i in range(1, 11):
    total += i

print("Total:", total)

#  TABLE USING LOOP 
number = 5
for i in range(1, 11):
    print(number, "x", i, "=", number * i)


#  WHILE LOOP EXAMPLE 

count = 10
while count > 0:
    print("Count:", count)
    count -= 1