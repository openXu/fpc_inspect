
///页面数据传递统一数据结构
class Bundle{

  Map<String, dynamic> _map = {};

  _setValue(String key, var value) => _map[key] = value;

  _getValue(String key){
    if(!_map.containsKey(key)){
      throw Exception("参数$key 在$_map中不存在");
    }
    return _map[key];
  }

  putInt(String key, int value)=>_map[key] = value;
  putString(String key, String value)=>_map[key] = value;
  putBool(String key, bool value)=>_map[key] = value;
  putList<V>(String key, List<V> value)=>_map[key] = value;
  putMap<K, V>(String key, Map<K, V> value)=>_map[key] = value;




}