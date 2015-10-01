package com.sysuwater.biz;

/**
 * °æ¿é
 * @author
 *
 */
public class Plate {
	
	/**
	 * °æ¿é ID
	 */
	private int pid;
	
	/**
	 * °æ¿éÃû³Æ
	 */
	private String pname;
	
	public int getPid(){
		return pid;
	}
	
	public void setPid(int pid){
		this.pid = pid;
	}
	
	public String getPname(){
		return pname;
	}
	
	public void setPname(String pname){
		this.pname = pname;
	}
	
	/**
	 * ´´½¨ÐÂ°æ¿é£¬ÔÝÊ±²»Ð´
	 * 
	 * @param pname
	 * @return
	 */
	public boolean createNewPlate(String pname){
		return true;
	}

}
