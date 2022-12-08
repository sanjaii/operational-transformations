# Operational Transformations



Install dependencies using `bundle install`.

run `lib/app.rb` for starting the server. By default the port is `4567`.

## Test Cases

### SAMPLE TEST CASE 1

```curl
 curl \
  -X POST \
  -H "Content-Type: application/json" \
  "http://127.0.0.1:4567/v1/operations/transform" \
  -d '{ "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.", "operations": [ { "op": "skip", "count": 40 }, { "op": "delete", "count": 47 } ] }'
  

 OUTPUT : { "latest": "Repl.it uses operational transformations." }
```

### SAMPLE TEST CASE 2
```curl
 curl \
  -X POST \
  -H "Content-Type: application/json" \
  "http://127.0.0.1:4567/v1/operations/transform" \
  -d '{ "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.", "operations": [ { "op": "delete", "count": 7 }, { "op": "insert", "chars": "We" }, { "op": "skip", "count": 4 }, { "op": "delete", "count": 1 } ] }'
  
 OUTPUT : { "latest": "We use operational transformations to keep everyone in a multiplayer repl in sync."}
```

### SAMPLE TEST CASE 3
```curl
 curl \
  -X POST \
  -H "Content-Type: application/json" \
  "http://127.0.0.1:4567/v1/operations/transform" \
  -d '{ "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.", "operations": [ { "op": "skip", "count": 45 }, { "op": "delete", "count": 47 } ] }'
  
 OUTPUT :  { "message": "Transformations failed on the input" }
```

### SAMPLE TEST CASE 4

```curl
 curl \
  -X POST \
  -H "Content-Type: application/json" \
  "http://127.0.0.1:4567/v1/operations/transform" \
  -d '{ "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.", "operations": [ { "op": "skip", "count": 40 }, { "op": "delete", "count": 47 }, { "op": "skip", "count": 2 } ] }'
  
 OUTPUT : { "message": "Transformations failed on the input" }
```

### SAMPLE TEST CASE 5

```curl
 curl \
  -X POST \
  -H "Content-Type: application/json" \
  "http://127.0.0.1:4567/v1/operations/transform" \
  -d '{ "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.", "operations": [] }'
  
 OUTPUT : { "latest": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync." }
```
