from datetime import datetime

def back_in_time():
    print("I've built this time machine to get back in time!\n")
    now = datetime.now()

    dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
    print("Current date is...")
    print('.')
    print('.')
    print('.')
    print(dt_string)

    if dt_string:
        print("Fvck... Maybe there is something broke here...")

if __name__ == "__main__":
    back_in_time()
