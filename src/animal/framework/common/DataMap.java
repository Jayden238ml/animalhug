package animal.framework.common;

import java.io.Serializable;

import org.apache.commons.collections.FastHashMap;

public class DataMap extends FastHashMap implements Serializable{
	private static final long serialVersionUID = 1L;
	 
	/**
	 * ������ key�� ����� ��ü�� ���ڿ��� ��ȯ�Ͽ� ��ȯ�Ѵ�. 
	 * ���� key�� ���� ����� ���� ���ų� null�� ����� ��� ���鹮�ڿ�("")�� ��ȯ�Ѵ�.<p>
	 *  
	 * @param key ���� ���� �����ϱ� ���� key
	 * @return ������ key�� ����� ��ü�� ���ڿ��� ��ȯ�� �� �Ǵ� ������ key�� �ش��ϴ� HTTP ��û �Ķ���� ��. ���� �� ���� null�� ��� ���鹮�ڿ�("")�� ��ȯ�Ѵ�.   
	 */
	public String getString(String key) {
		if (key == null) {
			return "";
		}
		Object value = get(key);
		if (value == null) {
			return "";
		}
		return value.toString();
	}
	
	/**
	 * ������ key�� ����� ��ü�� int������ ��ȯ�Ͽ� ��ȯ�Ѵ�. 
	 * ���� key�� ���� ����� ���� ���ų� null�� ����� ��� 0�� ��ȯ�Ѵ�.<p>
	 *
	 * @param key ���� ���� �����ϱ� ���� key
	 * @return ������ key�� ����� ��ü�� int�� ��ȯ�� ��. ���� ���� null�� 0�� ��ȯ�Ѵ�.   
	 */
	public int getInt(String key) {
		if (key == null) {
			return 0;
		}
		
		Object value = get(key);
		
		if (value == null) {
			return 0;
		}
		
		if (value instanceof java.lang.String) {
			try {
				return Integer.parseInt((String)value);
			} catch(NumberFormatException e) {
				return 0;
			}
		}
		else if (value instanceof java.lang.Number) {
			return ((Number)value).intValue();
		}
		else {
			return 0;
		}
	}

	/**
	 * ������ key�� ����� ��ü�� long������ ��ȯ�Ͽ� ��ȯ�Ѵ�. 
	 * ���� key�� ���� ����� ���� ���ų� null�� ����� ��� 0�� ��ȯ�Ѵ�.<p>
	 *
	 * @param key ���� ���� �����ϱ� ���� key
	 * @return ������ key�� ����� ��ü�� long���� ��ȯ�� ��. ���� ���� null�� 0�� ��ȯ�Ѵ�.   
	 */
	public long getLong(String key) {
		if (key == null) {
			return 0;
		}
		
		Object value = get(key);
		
		if (value == null) {
			return 0;
		}
		
		if (value instanceof java.lang.String) {
			try {
				return Long.parseLong((String)value);
			} catch(NumberFormatException e) {
				return 0;
			}
		}
		else if (value instanceof java.lang.Number) {
			return ((Number)value).longValue();
		}
		else {
			return 0;
		}
	}

	/**
	 * ������ key�� ����� ��ü�� double������ ��ȯ�Ͽ� ��ȯ�Ѵ�. 
	 * ���� key�� ���� ����� ���� ���ų� null�� ����� ��� 0�� ��ȯ�Ѵ�.<p>
	 *
	 * @param key ���� ���� �����ϱ� ���� key
	 * @return ������ key�� ����� ��ü�� double������ ��ȯ�� ��. ���� ���� null�� 0�� ��ȯ�Ѵ�.   
	 */
	public double getDouble(String key) {
		if (key == null) {
			return 0;
		}
		
		Object value = get(key);
		
		if (value == null) {
			return 0;
		}
		
		if (value instanceof java.lang.String) {
			try {
				return Double.parseDouble((String)value);
			} catch(NumberFormatException e) {
				return 0;
			}
		}
		else if (value instanceof java.lang.Number) {
			return ((Number)value).doubleValue();
		}
		else {
			return 0;
		}
	}
	
	@Override
	public Object get(Object key) {
		if(!super.containsKey(key)){
			return "";
		}
		return super.get(key);
	}
	
	
	@Override
	public Object put(Object key, Object value) {
		if(value == null || value.equals("null")){
			return super.put(key.toString(), "");
		}
		return super.put(key.toString(), value);
	}
}
