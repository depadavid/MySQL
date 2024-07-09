# Apuntes mongo

## 1. CRUD operations

### 1.1 Insert documents

#### 1.1.1 Create operations

```sql
db.collection.insertOne()
db.collection.insertMany()
db.inventory.insertOne(
   { item: "canvas", qty: 100, tags: ["cotton"], size: { h: 28, w: 35.5, uom: "cm" } })
db.inventory.find( { item: "canvas" } )
db.inventory.insertMany([
   { item: "journal", qty: 25, tags: ["blank", "red"], size: { h: 14, w: 21, uom: "cm" } },
   { item: "mat", qty: 85, tags: ["gray"], size: { h: 27.9, w: 35.5, uom: "cm" } },
   { item: "mousepad", qty: 25, tags: ["gel", "blue"], size: { h: 19, w: 22.85, uom: "cm" } }])

```

![The components of a MongoDB insertOne operations.](https://www.mongodb.com/docs/manual/images/crud-annotated-mongodb-insertOne.bakedsvg.svg)

#### 1.1.2 Read operations

```sql
db.collection.find()
```

![The components of a MongoDB find operation.](https://www.mongodb.com/docs/manual/images/crud-annotated-mongodb-find.bakedsvg.svg)

#### 1.1.3 Update operations

```sql
db.collection.updateOne()
db.collection.updateMany()
db.collection.replaceOne()
```

![The components of a MongoDB updateMany operation.](https://www.mongodb.com/docs/manual/images/crud-annotated-mongodb-updateMany.bakedsvg.svg)

#### 1.1.4 Delete operations

```sql
db.collection.deleteOne()
db.collection.deleteMany()
```

![The components of a MongoDB deleteMany operation.](https://www.mongodb.com/docs/manual/images/crud-annotated-mongodb-deleteMany.bakedsvg.svg)