package modele;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.YearMonth;
import java.util.Calendar;
import java.util.Date;

public class Month {
	
	private int month;
	private int year;
	private Date date;
	
	public Month(int month, int year) {
		this.month = month;
		this.year = year;
	}
	
	public String getDay(int day) throws ParseException {
		this.setDate(day);
		Calendar c = Calendar.getInstance();
		c.setTime(this.date);

		SimpleDateFormat sdf = new SimpleDateFormat("dd");
		String _day = sdf.format(c.getTime());
		
		return _day;
	}
	
	public String getMonth(int day) throws ParseException {
		this.setDate(day);
		Calendar c = Calendar.getInstance();
		c.setTime(this.date);

		SimpleDateFormat sdf = new SimpleDateFormat("MMMM");
		String _month = sdf.format(c.getTime());
		
		return _month;
	}
	
	public String getYear(int day) throws ParseException {
		this.setDate(day);
		Calendar c = Calendar.getInstance();
		c.setTime(this.date);
		
		SimpleDateFormat sdf = new SimpleDateFormat("Y");
		String _year = sdf.format(c.getTime());
		
		return _year;
	}
	
	public int getMonthDays(){
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year, this.month - 1, 1);
		int maxDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		return maxDay;
	}	
	
	public Date getDate() {
		return this.date;
	}
	
	public void setDate(int day) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-dd");
		String dateInString = this.year + "-" + this.month + "-" + day;
		this.date = sdf.parse(dateInString);
	}
	
	public String getFullDate(int day) throws ParseException {
		this.setDate(day);
		Calendar c = Calendar.getInstance();
		c.setTime(this.date);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String fullDate = sdf.format(c.getTime());
		
		return fullDate;
	}
}
