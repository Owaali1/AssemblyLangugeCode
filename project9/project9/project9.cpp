// project9.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include "project9.h"
#include <math.h>
#define MAX_LOADSTRING 100

// Global Variables:
HINSTANCE hInst;                                // current instance
WCHAR szTitle[MAX_LOADSTRING];                  // The title bar text
WCHAR szWindowClass[MAX_LOADSTRING];            // the main window class name

// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPWSTR    lpCmdLine,
                     _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    // TODO: Place code here.

    // Initialize global strings
    LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadStringW(hInstance, IDC_PROJECT9, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Perform application initialization:
    if (!InitInstance (hInstance, nCmdShow))
    {
        return FALSE;
    }

    HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_PROJECT9));

    MSG msg;

    // Main message loop:


    while (GetMessage(&msg, nullptr, 0, 0))
    {
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    return (int) msg.wParam;
}



//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEXW wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style          = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = WndProc;
    wcex.cbClsExtra     = 0;
    wcex.cbWndExtra     = 0;
    wcex.hInstance      = hInstance;
    wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_PROJECT9));
    wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW+1);
    wcex.lpszMenuName   = MAKEINTRESOURCEW(IDC_PROJECT9);
    wcex.lpszClassName  = szWindowClass;
    wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

    return RegisterClassExW(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   hInst = hInstance; // Store instance handle in our global variable

   HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      700, 0, 615, 460, nullptr, nullptr, hInstance, nullptr);

   if (!hWnd)
   {
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE:  Processes messages for the main window.
//
//  WM_COMMAND  - process the application menu
//  WM_PAINT    - Paint the main window
//  WM_DESTROY  - post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
    case WM_COMMAND:
        {
            int wmId = LOWORD(wParam);
            // Parse the menu selections:
            switch (wmId)
            {
            case IDM_ABOUT:
                DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
                break;
            case IDM_EXIT:
                DestroyWindow(hWnd);
                break;
            default:
                return DefWindowProc(hWnd, message, wParam, lParam);
            }
        }
        break;
    case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hWnd, &ps);
            // TODO: Add any drawing code that uses hdc here...
			//x*x-4
			_asm {
				push 0;
				push 0;
				push 300;
				push hdc;
				call MoveToEx;
				
				push 400;
				push 300;
				push hdc;
				call LineTo;

				push 0;
				push 200;
				push 0;
				push hdc;
				call MoveToEx;

				push 200;
				push 600;
				push hdc;
				call LineTo;



				
				}

		
			
			float x = -7.5f;
			int grx = 0;
			int gry = 0;
			int ph = 40;
			int w2 = 300;
			int h2 = 200;
			int  yscale = 4;
			float fx = 0.05f;
			_asm {
				fld x;
				fild ph;
				fmul;
				fiadd w2;
				fistp grx;
				/*
				fld x;
				fmul x;
				fimul ph;
				fld h2;
				fsub;
				fistp gry

				
				*/
				fld x;
				fsin;
				fimul yscale;
				fimul ph;
				fild h2;
				fsubr;
				fistp gry;
			
				push 0;
				push gry
				push grx
				push hdc
				call MoveToEx


					
					
					
					
					
					//add x, .05

					//fld x;
				//	fld x;
				//	fmul;

			}
			
			_asm{
				push ebx;//save it 
				xor ebx, ebx;// zero it
				L10:
				fld x;
				fld fx;
				fadd;
				fstp x;

					fld x;
					fild ph;
					fmul;
					fiadd w2;
					fistp grx;

					fld x;
					fsin;
					fimul yscale;
					fimul ph;
					fild h2;
					fsubr
					fistp gry;




				/*
					fld x;
					fmul x;
					fimul ph;

					fld h2;
					fsub
					fistp gry;


						*/
						push gry
						push grx
						push hdc
						call LineTo
				

						
						inc ebx
					cmp ebx, 300;
					jne L10;
					pop ebx;
				
			} 
			
			
			/*	
			float x = -7.5f;;
			float y = x*x*x;
			int grx = round(x * 40 + 300);
			int gry = round(200 - 40 * y);
			MoveToEx(hdc, grx, gry, NULL);
			
			
			while (x < 7.5f)
			{
				x += .05f;
				y = x*x*x;
				grx = round(x * 40 + 300);
				gry = round(200 - 40 * y);
				LineTo(hdc, grx, gry);
			}

		*/
			
			/*
			MoveToEx(hdc, 300, 0, NULL);
			LineTo(hdc, 300, 390);
			MoveToEx(hdc, 0, 200, NULL);
			LineTo(hdc, 585, 200);
			*/
        }
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
    switch (message)
    {
    case WM_INITDIALOG:
        return (INT_PTR)TRUE;

    case WM_COMMAND:
        if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (INT_PTR)FALSE;
}
