package bean;

public class products {
	private int id;
	private String name;
	private double price;
	private String description;
	private int quantity;
	private String image;
	
	
	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public products() {};
	
	
	public int getId() {
		return id;
	}
	public void setId(int pid) {
		this.id = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String pname) {
		this.name = pname;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
}
