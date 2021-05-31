package ex.java.day12;

public interface Calc {
	// 인스턴스로 선언한 변수는 컴파일 과정에서 상수로 변환됨
	double PI = 3.14;
	int ERROR = -999999;
	
	// 인터페이스에서 선언한 메서드는 컴파일 과정에서 추상 메서드로 변환됨
	int add(int num1, int num2);
	int substract(int num1, int num2);
	int times(int num1, int num2);
	int divide(int num1, int num2);
	
	// 디폴트 메서드
	default void description() {
		System.out.println("정수 계산기를 구현한다.");
	}
	
	// 정적 메서드
	static int total(int[] arr) {
		int total = 0;
		
		for(int i : arr) {
			total += i;
		}
		
		return total;
	}
}
