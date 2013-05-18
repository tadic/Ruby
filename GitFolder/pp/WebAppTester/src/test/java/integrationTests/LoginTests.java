package integrationTests;



/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
/**
 *
 * @author ivantadic
 */
public class LoginTests {
    WebDriver driver;
    
    @Before
    public void setUp() {
        driver = new HtmlUnitDriver();
        driver.get("https://www.dliv.in");
    }
    
    @Test
    public void userCanLoginWithCorrectUsernameAndPassword(){
        String expected = "Ivan Tadic | Digital Living";
        WebElement element= driver.findElement(By.name("email"));
        element.sendKeys("ivan.tadic014@gmail.com");
        element = driver.findElement(By.name("pass"));
        element.sendKeys("roki014");
        element.submit();
        assertEquals(expected, driver.getTitle());
    }

}
