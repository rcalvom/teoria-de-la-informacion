P = [1,0,1; 1,1,1; 1,1,0];
Ht = [P'; eye(3)]
r = input()
s = r*Ht
error =0
for i=1; size(Ht,1)
    if isequal(s, Ht(i,:))
        printf("error, el vector de comparación esta en la matriz")
        error= 1
    end
end
