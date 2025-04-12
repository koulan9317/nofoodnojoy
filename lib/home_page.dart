import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

/// 首頁元件，顯示使用者歡迎訊息、下拉選單與底部按鈕列
class HomePage extends StatefulWidget {
  final String username; // 傳入的帳號名稱（不是 displayName）
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedAction; // 記錄目前下拉選單的選項（暫時未使用）

  /// 處理選單的選項
  void handleSelection(String? value) {
    if (value == null) return;

    if (value == 'edit') {
      // 選擇更改用戶名（目前僅顯示提示，尚未實作編輯功能）
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('功能尚未實作：更改用戶名')),
      );
    } else if (value == 'logout') {
      // 登出功能：清除 Firebase 登入狀態並返回登入頁面
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }

    setState(() => selectedAction = null); // 重置選項
  }

  /// 顯示功能提示（給底部按鈕用）
  void showFeatureHint(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 左上角顯示使用者帳號與下拉選單
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person, color: Colors.black),
            const SizedBox(width: 8),
            DropdownButton<String>(
              underline: const SizedBox(), // 移除底線
              dropdownColor: Colors.white, // 下拉背景白色
              value: null, // 不設定預設值，保持提示文字
              hint: Text(
                "歡迎，${widget.username}",
                style: const TextStyle(color: Colors.black),
              ),
              iconEnabledColor: Colors.black, // 下拉箭頭顏色
              items: const [
                DropdownMenuItem(
                  value: 'edit',
                  child: Text('更改用戶名'),
                ),
                DropdownMenuItem(
                  value: 'logout',
                  child: Text('登出'),
                ),
              ],
              onChanged: handleSelection,
            ),
          ],
        ),
      ),

      // 中間顯示主文字內容
      body: const Center(
        child: Text(
          "吃，是人生一大樂事！",
          style: TextStyle(fontSize: 24),
        ),
      ),

      // 底部四欄按鈕列
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // 美化形狀
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // 平均分配四欄
          children: [
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () => showFeatureHint('尚未導入地圖功能'),
              tooltip: '地圖',
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () => showFeatureHint('尚未導入收藏功能'),
              tooltip: '收藏',
            ),
            IconButton(
              icon: const Icon(Icons.construction),
              onPressed: () => showFeatureHint('此功能待開發'),
              tooltip: '待開發',
            ),
            IconButton(
              icon: const Icon(Icons.construction),
              onPressed: () => showFeatureHint('此功能待開發'),
              tooltip: '待開發',
            ),
          ],
        ),
      ),
    );
  }
}
