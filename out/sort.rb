require "scanf.rb"
def copytab( tab, len )
    o = [];
    for i in (0 ..  len - 1) do
      o[i] = tab[i];
    end
    return (o);
end

def bubblesort( tab, len )
    for i in (0 ..  len - 1) do
      for j in (i + 1 ..  len - 1) do
        if tab[i] > tab[j] then
          tmp = tab[i]
          tab[i] = tab[j];
          tab[j] = tmp;
        end
      end
    end
end

def qsort_( tab, len, i, j )
    if i < j then
      i0 = i
      j0 = j
      
=begin
 pivot : tab[0] 
=end

      while i != j do
        if tab[i] > tab[j] then
          if i == j - 1 then
            
=begin
 on inverse simplement
=end

            tmp = tab[i]
            tab[i] = tab[j];
            tab[j] = tmp;
            i += 1
          else
            
=begin
 on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] 
=end

            tmp = tab[i]
            tab[i] = tab[j];
            tab[j] = tab[i + 1];
            tab[i + 1] = tmp;
            i += 1
          end
        else
          j -= 1
        end
      end
      qsort_(tab, len, i0, i - 1);
      qsort_(tab, len, i + 1, j0);
    end
end

len = 2
len=scanf("%d")[0];
scanf("%*\n");
tab = [];
for i_ in (0 ..  len - 1) do
  tmp = 0
  tmp=scanf("%d")[0];
  scanf("%*\n");
  tab[i_] = tmp;
end
tab2 = copytab(tab, len)
bubblesort(tab2, len);
for i in (0 ..  len - 1) do
  printf "%d ", tab2[i]
end
print "\n";
tab3 = copytab(tab, len)
qsort_(tab3, len, 0, len - 1);
for i in (0 ..  len - 1) do
  printf "%d ", tab3[i]
end
print "\n";

