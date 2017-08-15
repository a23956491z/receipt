#include <vector>
#include <cmath>
#include <string>
#include <Python.h>

void online_get_invoice(){

    Py_Initialize();
    PyObject *pModule,*pFunc;
    PyObject *pArgs, *pValue;
    PyObject *pModuleString = PyString_FromString((char*)"invoice");

    pModule = PyImport_Import(pModuleString);
    pFunc = PyObject_GetAttrString(pModule, (char*)"online_get_invoice");

    pArgs = PyTuple_Pack(1);

    pValue = PyObject_CallObject(pFunc, pArgs);

    Py_Finalize();
    return;


}
