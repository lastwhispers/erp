package cn.xlr.erp.entity;
/**
 * 仓库实体类
 * @author Administrator *
 */
public class Store {	
	private Long uuid;//编号
	private String name;//名称
	private Long empuuid;//员工编号

	public Long getUuid() {		
		return uuid;
	}
	public void setUuid(Long uuid) {
		this.uuid = uuid;
	}
	public String getName() {		
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getEmpuuid() {		
		return empuuid;
	}
	public void setEmpuuid(Long empuuid) {
		this.empuuid = empuuid;
	}

}
