#include <bits/stdc++.h>
using namespace std;

int digitSum(int n){
    int first,last,sum;

    last = n%10;
    while(n>=10){
        n=n/10;
    }
    first =n;
    sum = last+first;

    return sum;
}

int main(){
    int x;
    cin >> x;
    cout << digitSum(x);
}
