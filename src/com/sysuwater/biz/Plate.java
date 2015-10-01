package com.sysuwater.biz;

/**
 * 版块
 * @author
 *
 */
public class Plate {
	
	/**
	 * 版块 ID
	 */
	private int pid;
	
	/**
	 * 版块名称
	 */
	private String pname;
	
	/**
	 * 版块介绍
	 */
	private String introduction;
	
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

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
	 * 获取所有版块
	 * @return
	 */
	public Plate[] getPlateList(){
		Plate[] plates = new Plate[2];
		plates[0].pid = 1;
		plates[0].pname = "学术探讨";
		plates[0].introduction = "这里是学术的失乐园";
		
		plates[1].pid = 2;
		plates[0].pname = "八卦天地";
		plates[1].introduction = "哇咔咔";
		return plates;
	}
	
	/**
	 * 创建新版块，暂时不写
	 * 
	 * @param pname
	 * @return
	 */
	public boolean createNewPlate(String pname){
		return true;
	}

}
