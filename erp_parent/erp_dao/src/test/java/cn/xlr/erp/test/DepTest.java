package cn.xlr.erp.test;


import java.sql.SQLException;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext_datasource.xml"})
public class DepTest {
	
//	@Autowired
//	private DataSource dataSource;
	
	@Test
	public void testLogic() throws SQLException{
//		Connection connection = dataSource.getConnection();
//		PreparedStatement prepareStatement = connection.prepareStatement("select * from tab");
//		ResultSet resultSet = prepareStatement.executeQuery();
//		while(resultSet.next()) {
//			String string = resultSet.getString(0);
//			System.out.println(string);
//		}
	}
	

}
