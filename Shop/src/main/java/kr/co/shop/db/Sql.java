package kr.co.shop.db;

public class Sql {
	
	public static final String SELECT_CUSTOMER = "select * from `customer`";
	
	public static final String SELECT_ORDERS = "SELECT a.*, b.`name`, c.`prodName` FROM `order` AS a "
												  + "JOIN `customer` AS b ON a.orderId = b.custid "
													+ "JOIN `product` AS c on a.orderProduct = c.prodNo";

	public static final String SELECT_PRODUCT = "select * from `product`";

}
