
using namespace std;

class IntStack
{
private:
    int *stackArray;
    int stackSize;
    int top;

public:
    IntStack(int);
    void push(int);
    void pop(int &);
    bool isFull(void);
    bool isEmpty(void);
};

IntStack::IntStack(int size)
{
    stackArray = new int[size];
    stackSize = size;
    top = -1;
}

void IntStack::push(int num)
{
    if (isFull())
    {
        cout << "The stack is full.\n";
    }
    else
    {
        top++;
        stackArray[top] = num;
    }
}

void IntStack::pop(int &num)
{
    if (isEmpty())
    {
        cout << "The stack is empty.\n";
    }
    else
    {
        num = stackArray[top];
        top--;
    }
}

bool IntStack::isFull(void)
{
    bool status;
    if (top == stackSize - 1)
        status = true;
    else
        status = false;
    return status;
}

bool IntStack::isEmpty(void)
{
    bool status;
    if (top == -1)
        status = true;
    else
        status = false;
    return status;
}

int main()
{
    IntStack stack(5);
    int num;
    cout << "Created an empty stack with capacity 5, trying to pop. \n";
    stack.pop(num);
    int values[] = {2, 7, 10, 5, 3, 8, 11};
    cout << "\nPushing...\n";
    for (int k = 0; k < 7; k++)
    {
        cout << values[k] << " ";
        stack.push(values[k]);
        cout << endl;
    }
    cout << "\nPopping...\n";
    while (!stack.isEmpty())
    {
        stack.pop(num);
        cout << num << endl;
    }
    cout << endl;
    return 0;
}