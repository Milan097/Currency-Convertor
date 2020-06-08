#include<bits/stdc++.h>
using namespace std;
string s;
int pos = 0;

/*
	Grammer:
	
	E -> BST
	B -> DB'
	B' -> .D | ^
	D -> D'
	D' -> DD' | ^
	T -> KSO
	K -> Keywords...
	O -> =S?SK
	S -> ' '
	D -> [0-9]
*/



int match(char a) {
    cout<<"match()\n";
    if(a == s[pos]) {
        pos++;
        return true;
    }
}

int matchDg(char a) {
    cout<<"matchDg()\n";
    if(a>='0' && a<='9') {
        pos++;
        return true;
    }
}

bool matchKW (int a) {
    cout<<"matchKW()\n";
    if(s.substr(a,3) == "AUD" || s.substr(a,3) == "INR" || s.substr(a,3) == "EUR" || s.substr(a,3) == "USD" || s.substr(a,3) == "CAD" || s.substr(a,3) == "JPY" || s.substr(a,3) == "MXN"  ) {
        pos += 3;
        cout<<"------- "<<s.substr(a,3)<<" ------- found\n";
        return true;
    }
}

void K() {
    cout<<"K()\n";
    matchKW(pos);
}

void O() {
    cout<<"O()\n";
    if(match('=') == true)
        if(match(' ') == true)
            if(match('?') == true)
                if(match(' ') == true)
                    K();
}

void T() {
    cout<<"T()\n";
    K();
    if(match(' ') == true)
        O();
}

void D1 () {
    cout<<"D1()\n";
    if(matchDg(s[pos]) == true)
        D1();
    else
        return;
}

void D() {
    cout<<"D()\n";
    if(matchDg(s[pos]) == true)
        D1();
}

void B1() {
    cout<<"B1()\n";
    if(match('.') == true)
        D();
    else
        return;
}

void B() {
    cout<<"B()\n";
    D();
    B1();
}

void E() {
    cout<<"E()\n";
    B();
    if(match(' ') == true)
        T();
}

int main() {
    getline(cin,s);
    //s = "55.55 AUD = ? INR$";
    E();
    if(s[pos] == '$')
        cout<<"Successfull Parsing..\n";
    else
        cout<<"Fail\n";
    return 0;
}