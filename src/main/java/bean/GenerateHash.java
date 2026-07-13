package bean;
import org.mindrot.jbcrypt.BCrypt;

public class GenerateHash {
	public static void main(String[] args) {
        String plain = "admin123";
        String hash = BCrypt.hashpw(plain, BCrypt.gensalt());
        System.out.println(hash);
    }
}
