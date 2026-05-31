import redis

r = redis.Redis(host='redis', port=6379, decode_responses=True)

# --- set, get, mset, mget, delete ---
print('--- set, get, mset, mget, delete ---')
r.set('foo', 'bar')
value = r.get('foo')
print(value)

r.mset({'a': '10', 'b': '20', 'c': '30'})
values = r.mget(['a', 'b', 'c'])
for v in values:
    print(v)

# --- incr, decr, incrby, decrby ---
print('--- incr, decr, incrby, decrby ---')
r.set('counter', '100')
r.incr('counter')
r.incrby('counter', 9)
r.decrby('counter', 4)
counter = r.decr('counter')
print('counter:', counter)

# --- append, getrange, strlen ---
print('--- append, getrange, strlen ---')
r.set('greeting', 'Hello ')
if r.exists('greeting'):
    r.append('greeting', 'World!')

print(r.getrange('greeting', 6, -1))
print(r.get('greeting'))
print('Length:', r.strlen('greeting'))

r.delete('greeting')

# --- Listas ---
print('--- Listas ---')
r.delete('sessions:ggvd')

r.lpush('sessions:ggvd', '10/3')
r.rpush('sessions:ggvd', '24/3')
r.rpush('sessions:ggvd', '25/3')
r.rpop('sessions:ggvd')
r.linsert('sessions:ggvd', 'BEFORE', '24/3', '17/3')
r.rpush('sessions:ggvd', '31/3')
r.lset('sessions:ggvd', -1, '7/4')

values = r.lrange('sessions:ggvd', 0, -1)
for v in values:
    print(v)

r.delete('sessions:ggvd')

# --- Sets ---
print('--- Sets ---')
r.delete('students:ggvd')

r.sadd('students:ggvd', 'student1', 'student2', 'student3')
r.srem('students:ggvd', 'student3')

students = r.smembers('students:ggvd')
number_of_students = r.scard('students:ggvd')

print(number_of_students)
for s in students:
    print(s)

r.delete('students:ggvd')

# --- Set Operations ---
print('--- Set Operations ---')
r.delete('students:ggvd')

r.sadd('students:ggvd', 'student1', 'student2', 'student3')
r.sadd('students:bd', 'student3', 'student4', 'student5')

total_students = r.sunion('students:bd', 'students:ggvd')
common_students = r.sinter('students:bd', 'students:ggvd')
students_only_in_ggvd = r.sdiff('students:ggvd', 'students:bd')

print('Total students:')
for s in total_students:
    print(s)

print('Common students:')
for s in common_students:
    print(s)

print('Students only in GGVD:')
for s in students_only_in_ggvd:
    print(s)

r.delete('students:ggvd')
r.delete('students:bd')

# --- Sorted Sets ---
print('--- Sorted Sets ---')
r.delete('scores:ggvd')

r.zadd('scores:ggvd', {'student1': 9})
r.zadd('scores:ggvd', {'student2': 3})
r.zadd('scores:ggvd', {'student3': 8})

r.zincrby('scores:ggvd', 1, 'student2')

number_of_pass_students = r.zcount('scores:ggvd', 5, 10)
print(number_of_pass_students)

pass_students = r.zrangebyscore('scores:ggvd', 5, 10, withscores=True)
print('Pass Students')
for s, score in pass_students:
    print(s, score)

r.delete('scores:ggvd')

# --- Hashes ---
print('--- Hashes ---')
r.hset('profesor:mtorres', 'email', 'mtorres@ual.es')
r.hset('profesor:mtorres', 'name', 'Manuel')
r.hset('profesor:mtorres', 'surname', 'Torres Gil')
r.hset('profesor:mtorres', 'twitter', '@ualmtorres')

keys = r.hkeys('profesor:mtorres')
for k in keys:
    print(k + ': ' + r.hget('profesor:mtorres', k))

# --- Transactions ---
print('--- Transactions ---')
pipe = r.pipeline()
pipe.set('a', '1')
pipe.set('b', '2')
pipe.execute()

print('After execute()')
print('a:', r.get('a'), 'b:', r.get('b'))

pipe = r.pipeline()
pipe.set('a', '3')
pipe.set('b', '4')
pipe.reset()

print('After reset()')
print('a:', r.get('a'), 'b:', r.get('b'))
