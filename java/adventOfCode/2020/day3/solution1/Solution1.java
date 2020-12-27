import java.util.Scanner;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.io.IOException;

class FileObj {
	private static List<String> inputData;
	
	private static void readInputFromFile() {
		//read input from file
		try {
			inputData = Files.readAllLines(
			Paths.get("hillInput"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	FileObj(){
		readInputFromFile();	
		
	}
	
	public static List<String> getData(){
		return inputData;
	}
	
}

public class Solution1 {
	
	private static List<String> inputData;
	private static int totalLines = 0;
	private static int treeCount;
	private static int x = 1;
	private static int y = 0;
	
	public static int getTreeCount(int dx, int dy){
		countTrees(dx, dy);
		return treeCount;
	}
	
	private static void countTotalLines() {
		for (String line : inputData){
			totalLines++;
		}
		//System.out.println(totalLines);
	}
	
	private static void countTrees(int dx, int dy){
		String line = inputData.get(0);
		int length = line.length();
		treeCount = 0;
		while (y < totalLines-1){
			x += dx;
			if (x>length){
				x %= length;
			}
			y += dy;
			line = inputData.get(y);
			if (line.charAt(x-1)=='#'){
				treeCount++;
			}			
		}
	}
	
	Solution1(FileObj data) {
		inputData = data.getData();
		countTotalLines();
	}
	
	public static void main(String[] args) {
		FileObj data = new FileObj();
		Solution1 solution = new Solution1(data);
		System.out.println(solution.getTreeCount(1,2));	
	}
}
