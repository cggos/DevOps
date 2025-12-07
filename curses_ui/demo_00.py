#!/usr/bin/env python3
"""
Simple Curses Menu Demo
Author: 后端开发专家 (ISTJ)
Date: 2025-04-05

功能：
- 绘制菜单
- 上下箭头移动选择
- Enter 执行动作
- q 或 ESC 退出
"""

import curses


def draw_menu(stdscr):
    # 初始化颜色支持
    if not curses.has_colors():
        raise Exception("终端不支持颜色")

    curses.start_color()
    curses.init_pair(1, curses.COLOR_CYAN, curses.COLOR_BLACK)      # 标题
    curses.init_pair(2, curses.COLOR_WHITE, curses.COLOR_BLUE)     # 高亮选项
    curses.init_pair(3, curses.COLOR_BLACK, curses.COLOR_WHITE)    # 当前选中

    # 关闭光标闪烁
    curses.curs_set(0)

    # 启用键盘输入处理
    stdscr.keypad(True)

    # 菜单项
    menu_items = [
        " 1. 查看磁盘使用情况 (df -h) ",
        " 2. 查看内存信息 (free -h)   ",
        " 3. 显示当前目录文件       ",
        " 4. 退出程序                "
    ]

    current_row = 0

    while True:
        stdscr.clear()
        height, width = stdscr.getmaxyx()

        # 绘制标题栏
        title = "【Python Curses 简易系统工具】"
        stdscr.attron(curses.color_pair(1))
        stdscr.addstr(1, (width - len(title)) // 2, title)
        stdscr.attroff(curses.color_pair(1))

        # 绘制边框
        stdscr.border('|', '|', '-', '-', '+', '+', '+', '+')

        # 绘制菜单项
        for idx, item in enumerate(menu_items):
            x = (width - len(item)) // 2
            y = height // 2 - len(menu_items) // 2 + idx

            if idx == current_row:
                stdscr.attron(curses.color_pair(3))  # 反白高亮
                stdscr.addstr(y, x, item)
                stdscr.attroff(curses.color_pair(3))
            else:
                stdscr.addstr(y, x, item)

        # 提示信息
        hint = "↑↓ 移动 | Enter 执行 | q/ESC 退出"
        stdscr.addstr(height - 2, (width - len(hint)) // 2, hint, curses.A_DIM)

        stdscr.refresh()

        # 处理输入
        key = stdscr.getch()

        if key == ord('q') or key == 27:  # 'q' 或 ESC
            break
        elif key == curses.KEY_UP:
            current_row = (current_row - 1) % len(menu_items)
        elif key == curses.KEY_DOWN:
            current_row = (current_row + 1) % len(menu_items)
        elif key == ord('\n') or key == 10:  # Enter
            handle_action(stdscr, current_row)


def handle_action(stdscr, choice):
    """根据选择执行对应命令"""
    import subprocess
    import os

    commands = [
        ["df", "-h"],
        ["free", "-h"],
        ["ls", "-la"]
    ]

    if choice < 3:
        try:
            stdscr.clear()
            stdscr.addstr(2, 2, f"执行命令: {' '.join(commands[choice])}")
            stdscr.addstr(4, 2, "按任意键返回...")
            stdscr.refresh()

            result = subprocess.run(commands[choice], capture_output=True, text=True)
            output_lines = result.stdout.splitlines()
            err_lines = result.stderr.splitlines() if result.stderr else []

            y = 6
            for line in output_lines + err_lines:
                if y >= curses.LINES - 2:
                    break
                stdscr.addstr(y, 4, line[:curses.COLS - 8])
                y += 1

            stdscr.addstr(curses.LINES - 2, 2, "按任意键继续...")
            stdscr.refresh()
            stdscr.getch()
        except Exception as e:
            stdscr.addstr(8, 4, f"错误: {str(e)}")
            stdscr.getstr()  # 等待按键
    else:
        return  # 退出


def main():
    try:
        # 使用 wrapper 包装，自动处理初始化和清理
        curses.wrapper(draw_menu)
    except Exception as e:
        print(f"运行失败: {e}")


if __name__ == "__main__":
    main()

