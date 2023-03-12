# There are 2 popular way to prevent race condition in ruby on rails.

# 1: Use transaction to prevent race condition
def transfer_money(from_account, to_account, amount)
  if from_account.balance >= amount
    from_account.balance -= amount
    to_account.balance += amount
    from_account.save
    to_account.save
  end
end

# 2: Use lock to prevent race condition
def increment_image_views(image_id)
  image = Image.lock.find(image_id) # Lock
  image.views += 1
  image.save # Release lock
end