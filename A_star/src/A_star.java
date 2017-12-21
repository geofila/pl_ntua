
import java.io.*;
import java.util.PriorityQueue;

class Obj implements Comparable<Obj>{
    int i;
    int j;
    int distance;
    int f;
    public Obj(int i,int j,int distance,int f)
    {
        this.distance=distance;
        this.i=i;
        this.j=j;
        this.f=f;
    }
    public Obj() {
       
    }
    @Override
    public int compareTo(Obj o) {
        return f-o.f;
    }
 
     
}	

public class A_star {

    public static void main(String[] args) throws IOException {
    
    //Arxika diavazoume to arxeio keimenou
       // long startTime = System.currentTimeMillis();
        Obj heapData= new Obj();
        
        int i=0,j=0,col,rows,is=0,js=0,ie=0,je=0,dist=0;
        char c;
        
        BufferedReader reader = new BufferedReader(new FileReader(args[0]));
        String line = reader.readLine();
        col = line.length();
        rows = 1;
        while(reader.readLine() != null)	 rows++;

        //System.out.println(col +" " + rows);

        char map[][]= new char[col][rows];
        boolean visited[][]=new boolean [col][rows];
        int distance[][]= new int[col][rows];
        char prev[][]= new char[col][rows];
        
        prev[is][js]='S';
        reader.close();
        
        reader = new BufferedReader(new FileReader(args[0]));
        
        for (j=0;j<rows;j++){
            line = reader.readLine();
            for (i=0;i<col;i++){
                c=line.charAt(i);
                if (c=='S') {is=i; js=j;}
                else if (c=='E') {ie=i; je=j;}
                distance[i][j]=100000000;
                map[i][j]=c;
            }
        }
        //System.out.println(is+" "+js +" "+ ie +" "+je);
        reader.close();
        
        
        // orize thn priority queue
        PriorityQueue<Obj> pQueue=new PriorityQueue<Obj>();
        for (j=0; j<rows; j++) {
            for (i=0; i<col; i++) distance[i][j]=10000000;
        }
        //kanw push to thn prwth timh 
        pQueue.add(new Obj(ie,je,0,0));
        i=ie;
        j=je;
        //int count =0;

        while (map[i][j] !='S'){
            //count=count+1; //gia na doume poses fores mpainei se sxesh me dijkstra kai me apostash euler
            heapData= pQueue.remove();
            i=heapData.i;
            j=heapData.j;
            visited[i][j]=true;
            dist= heapData.distance;
            //System.out.println(heapData.f);
            if (i != col-1 &&  map[i+1][j]!= 'X' && distance[i+1][j]> dist+2){
                visited[i+1][j]=true;
                distance[i+1][j]=dist+2;
                prev[i+1][j]='L';
                pQueue.add(new Obj(i+1,j,dist+2,dist+2+Math.abs(i+1-is)+Math.abs(j-js)));// A* me manhatan apostaseis 
            }
            if (i != 0 &&  map[i-1][j]!= 'X' && distance[i-1][j]> dist+1){
                visited[i-1][j]=true;
                distance[i-1][j]=dist+1;
                prev[i-1][j]='R';
                pQueue.add(new Obj(i-1,j,dist+1,dist+1+Math.abs(i-1-is)+Math.abs(j-js)));
            }
            if (j != rows-1 &&  map[i][j+1]!= 'X' &&  distance[i][j+1]> dist+3){
                visited[i][j+1]=true;
                distance[i][j+1]=dist+3;
                prev[i][j+1]='U';
                pQueue.add(new Obj(i,j+1,dist+3,dist+3+Math.abs(i-is)+Math.abs(j+1-js)));
            }
            if (j != 0 &&  map[i][j-1]!= 'X' && distance[i][j-1]> dist+1){
                visited[i][j-1]=true;
                distance[i][j-1]=dist+1;
                prev[i][j-1]='D';
                pQueue.add(new Obj(i,j-1,dist+1,dist+1+Math.abs(i-is)+Math.abs(j-1-js)));
            }
            
            
        }
        System.out.print( distance[is][js]+ " ");
        /*for (j=0; j<rows; j++) {
            for (i=0; i<col; i++) System.out.print(prev[i][j] +"	");
            System.out.println("");
        }*/
        
        i=is;
        j=js;
        while (map[i][j]!= 'E'){
            System.out.print(prev[i][j]);
            if (prev[i][j]== 'R')	i=i+1;
            else if (prev[i][j]== 'L')	i=i-1;
            else if (prev[i][j]== 'D')	j=j+1;
            else if (prev[i][j]== 'U')	j=j-1;
            
        }
        //long endTime = System.currentTimeMillis();
        //System.out.println();
        //System.out.print("Xronos "+(endTime - startTime) + " ms"); 	
    }
}

