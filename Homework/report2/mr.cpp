class Mapper {
public:
  virtual void Map(const string& key, const string& value) = 0;
  virtual int Shard(const string& key, int num_reduce_shards);
protected:
  virtual void Output(const string& key, const string& value);
  virtual void OutputToShard(int reduce_shard,const string& key, const string& value);
  virtual void OutputToAllShards(const string& key, const string& value);
  const string& CurrentInputFilename() const;
  const string& GetInputFormat() const;
  const string& GetOutputFormat() const;
  int GetNumReduceShards() const;
  bool IsMapOnly() const;};
