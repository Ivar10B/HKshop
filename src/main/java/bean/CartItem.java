package bean;

public class CartItem {
	private products product;
	private int quantity;
	
	
	public CartItem() {}
	
	public CartItem(products product,int quantity) {
		this.product = product;
		this.quantity=quantity;
		
	}
	public products getProduct() {
		return product;
	}

	public void setProduct(products product) {
		this.product = product;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public double getTotalPrice() {
		return product.getPrice() * quantity;
	}
	
	
}
