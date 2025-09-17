# Exercise 4: inheritance, method overriding, encapsulation
# class BankAccount
# constructor: owner, balance
# methods: deposit, withdraw, display_balance
# class SavingAccount (inherits from BankAccount)
# constructor: owner, balance, interest_rate
# method: deposit + interest
# method: withdraw - amount + fee
# method: get_balance (overrides display_balance)
# class CurrentAccount (inherits from BankAccount)
# constructor: owner, balance, overdraft_limit



class BankAccount:

    def __init__(self, owner, balance):
        self.owner=owner
        self.balance=balance
    
    def deposit(self , amount):
        self.balance+= amount

    def withdraw(self, amount):
        self.balance-=amount

    def display_balance(self):
        print(f"{self.owner}'s Balance is {self.balance}")
    

class SavingAccount(BankAccount):
    def __init__(self, owner, balance, interest_rate):
        super().__init__(owner,balance)
        self.interest_rate=interest_rate
    

    def deposit_with_interest(self, amount):
        self.balance+= amount + (amount * self.interest_rate)
        
    

    def withdraw_with_fee(self,amount,fee):
        self.balance-=  (amount +fee) 


    def get_balance(self):
        print(f"{self.owner}'s Saving's Account Balance is {self.balance}")
    


class CurrentAccount(BankAccount):
    def __init__(self, owner, balance, overdraft_limit):
        super().__init__(owner, balance)
        self.overdraft_limit= overdraft_limit




ba = BankAccount("Akshay", 500)
ba.deposit(200)
ba.withdraw(100)
ba.display_balance()  # Expected: 600


sa = SavingAccount("Bajpai", 1000, 0.05)
sa.deposit_with_interest(200)  # 200 + 10 interest
sa.get_balance()  # Expected: 1210.0
sa.withdraw_with_fee(100, 5)
sa.get_balance()  # Expected: 1105.0

