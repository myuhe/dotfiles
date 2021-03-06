;; -*- mode: emacs-lisp; coding: utf-8-unix -*-
;;; mime-emoji-docomo.el --- docomo support for mime-emoji

;; Copyright (C) 2010  Kazuhiro Ito

;; Author: Kazuhiro Ito <kzhr@d1.dion.ne.jp>
;; Keywords: MIME, mail, Japanese

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;


;;; Code:

;; Constants
(defconst mime-emoji/docomo-list
  (eval-when-compile
    '(
      (#xE63E . "晴れ")
      (#xE63F . "曇り")
      (#xE640 . "雨")
      (#xE641 . "雪")
      (#xE642 . "雷")
      (#xE643 . "台風")
      (#xE644 . "霧")
      (#xE645 . "小雨")
      (#xE646 . "牡羊座")
      (#xE647 . "牡牛座")
      (#xE648 . "双子座")
      (#xE649 . "蟹座")
      (#xE64A . "獅子座")
      (#xE64B . "乙女座")
      (#xE64C . "天秤座")
      (#xE64D . "蠍座")
      (#xE64E . "射手座")
      (#xE64F . "山羊座")
      (#xE650 . "水瓶座")
      (#xE651 . "魚座")
      (#xE652 . "スポーツ")
      (#xE653 . "野球")
      (#xE654 . "ゴルフ")
      (#xE655 . "テニス")
      (#xE656 . "サッカー")
      (#xE657 . "スキー")
      (#xE658 . "バスケットボール")
      (#xE659 . "モータースポーツ")
      (#xE65A . "ポケットベル")
      (#xE65B . "電車")
      (#xE65C . "地下鉄")
      (#xE65D . "新幹線")
      (#xE65E . "車（セダン）")
      (#xE65F . "車（ＲＶ）")
      (#xE660 . "バス")
      (#xE661 . "船")
      (#xE662 . "飛行機")
      (#xE663 . "家")
      (#xE664 . "ビル")
      (#xE665 . "郵便局")
      (#xE666 . "病院")
      (#xE667 . "銀行")
      (#xE668 . "ＡＴＭ")
      (#xE669 . "ホテル")
      (#xE66A . "コンビニ")
      (#xE66B . "ガソリンスタンド")
      (#xE66C . "駐車場")
      (#xE66D . "信号")
      (#xE66E . "トイレ")
      (#xE66F . "レストラン")
      (#xE670 . "喫茶店")
      (#xE671 . "バー")
      (#xE672 . "ビール")
      (#xE673 . "ファーストフード")
      (#xE674 . "ブティック")
      (#xE675 . "美容院")
      (#xE676 . "カラオケ")
      (#xE677 . "映画")
      (#xE678 . "右斜め上")
      (#xE679 . "遊園地")
      (#xE67A . "音楽")
      (#xE67B . "アート")
      (#xE67C . "演劇")
      (#xE67D . "イベント")
      (#xE67E . "チケット")
      (#xE67F . "喫煙")
      (#xE680 . "禁煙")
      (#xE681 . "カメラ")
      (#xE682 . "カバン")
      (#xE683 . "本")
      (#xE684 . "リボン")
      (#xE685 . "プレゼント")
      (#xE686 . "バースデー")
      (#xE687 . "電話")
      (#xE688 . "携帯電話")
      (#xE689 . "メモ")
      (#xE68A . "ＴＶ")
      (#xE68B . "ゲーム")
      (#xE68C . "ＣＤ")
      (#xE68D . "ハート")
      (#xE68E . "スペード")
      (#xE68F . "ダイヤ")
      (#xE690 . "クラブ")
      (#xE691 . "目")
      (#xE692 . "耳")
      (#xE693 . "手（グー）")
      (#xE694 . "手（チョキ）")
      (#xE695 . "手（パー）")
      (#xE696 . "右斜め下")
      (#xE697 . "左斜め上")
      (#xE698 . "足")
      (#xE699 . "くつ")
      (#xE69A . "眼鏡")
      (#xE69B . "車椅子")
      (#xE69C . "新月")
      (#xE69D . "やや欠け月")
      (#xE69E . "半月")
      (#xE69F . "三日月")
      (#xE6A0 . "満月")
      (#xE6A1 . "犬")
      (#xE6A2 . "猫")
      (#xE6A3 . "リゾート")
      (#xE6A4 . "クリスマス")
      (#xE6A5 . "左斜め下")
      (#xE6AC . "カチンコ")
      (#xE6AD . "ふくろ")
      (#xE6AE . "ペン")
      (#xE6B1 . "人影")
      (#xE6B2 . "いす")
      (#xE6B3 . "夜")
      (#xE6B7 . "soon")
      (#xE6B8 . "on")
      (#xE6B9 . "end")
      (#xE6BA . "時計")
      (#xE6CE . "phone")
      (#xE6CF . "mail")
      (#xE6D0 . "fax")
      (#xE6D1 . "iモード")
      (#xE6D2 . "iモード（枠付き）")
      (#xE6D3 . "メール")
      (#xE6D4 . "ドコモ提供")
      (#xE6D5 . "ドコモポイント")
      (#xE6D6 . "有料")
      (#xE6D7 . "無料")
      (#xE6D8 . "ID")
      (#xE6D9 . "パスワード")
      (#xE6DA . "次項有")
      (#xE6DB . "クリア")
      (#xE6DC . "サーチ（調べる）")
      (#xE6DD . "ＮＥＷ")
      (#xE6DE . "位置情報")
      (#xE6DF . "フリーダイヤル")
      (#xE6E0 . "シャープダイヤル")
      (#xE6E1 . "モバＱ")
      (#xE6E2 . "1")
      (#xE6E3 . "2")
      (#xE6E4 . "3")
      (#xE6E5 . "4")
      (#xE6E6 . "5")
      (#xE6E7 . "6")
      (#xE6E8 . "7")
      (#xE6E9 . "8")
      (#xE6EA . "9")
      (#xE6EB . "0")
      (#xE6EC . "黒ハート")
      (#xE6ED . "揺れるハート")
      (#xE6EE . "失恋")
      (#xE6EF . "ハートたち（複数ハート）")
      (#xE6F0 . "わーい（嬉しい顔）")
      (#xE6F1 . "ちっ（怒った顔）")
      (#xE6F2 . "がく～（落胆した顔）")
      (#xE6F3 . "もうやだ～（悲しい顔）")
      (#xE6F4 . "ふらふら")
      (#xE6F5 . "グッド（上向き矢印）")
      (#xE6F6 . "るんるん")
      (#xE6F7 . "いい気分（温泉）")
      (#xE6F8 . "かわいい")
      (#xE6F9 . "キスマーク")
      (#xE6FA . "ぴかぴか（新しい）")
      (#xE6FB . "ひらめき")
      (#xE6FC . "むかっ（怒り）")
      (#xE6FD . "パンチ")
      (#xE6FE . "爆弾")
      (#xE6FF . "ムード")
      (#xE700 . "バッド（下向き矢印）")
      (#xE701 . "眠い(睡眠)")
      (#xE702 . "exclamation")
      (#xE703 . "exclamation&question")
      (#xE704 . "exclamation×2")
      (#xE705 . "どんっ（衝撃）")
      (#xE706 . "あせあせ（飛び散る汗）")
      (#xE707 . "たらーっ（汗）")
      (#xE708 . "ダッシュ（走り出すさま）")
      (#xE709 . "ー（長音記号１）")
      (#xE70A . "ー（長音記号２）")
      (#xE70B . "決定")
      (#xE70C . "iアプリ")
      (#xE70D . "iアプリ（枠付き）")
      (#xE70E . "Tシャツ（ボーダー）")
      (#xE70F . "がま口財布")
      (#xE710 . "化粧")
      (#xE711 . "ジーンズ")
      (#xE712 . "スノボ")
      (#xE713 . "チャペル")
      (#xE714 . "ドア")
      (#xE715 . "ドル袋")
      (#xE716 . "パソコン")
      (#xE717 . "ラブレター")
      (#xE718 . "レンチ")
      (#xE719 . "鉛筆")
      (#xE71A . "王冠")
      (#xE71B . "指輪")
      (#xE71C . "砂時計")
      (#xE71D . "自転車")
      (#xE71E . "湯のみ")
      (#xE71F . "腕時計")
      (#xE720 . "考えてる顔")
      (#xE721 . "ほっとした顔")
      (#xE722 . "冷や汗")
      (#xE723 . "冷や汗2")
      (#xE724 . "ぷっくっくな顔")
      (#xE725 . "ボケーっとした顔")
      (#xE726 . "目がハート")
      (#xE727 . "指でOK")
      (#xE728 . "あっかんべー")
      (#xE729 . "ウィンク")
      (#xE72A . "うれしい顔")
      (#xE72B . "がまん顔")
      (#xE72C . "猫2")
      (#xE72D . "泣き顔")
      (#xE72E . "涙")
      (#xE72F . "NG")
      (#xE730 . "クリップ")
      (#xE731 . "コピーライト")
      (#xE732 . "トレードマーク")
      (#xE733 . "走る人")
      (#xE734 . "マル秘")
      (#xE735 . "リサイクル")
      (#xE736 . "レジスタードトレードマーク")
      (#xE737 . "危険・警告")
      (#xE738 . "禁止")
      (#xE739 . "空室・空席・空車")
      (#xE73A . "合格マーク")
      (#xE73B . "満室・満席・満車")
      (#xE73C . "矢印左右")
      (#xE73D . "矢印上下")
      (#xE73E . "学校")
      (#xE73F . "波")
      (#xE740 . "富士山")
      (#xE741 . "クローバー")
      (#xE742 . "さくらんぼ")
      (#xE743 . "チューリップ")
      (#xE744 . "バナナ")
      (#xE745 . "りんご")
      (#xE746 . "芽")
      (#xE747 . "もみじ")
      (#xE748 . "桜")
      (#xE749 . "おにぎり")
      (#xE74A . "ショートケーキ")
      (#xE74B . "とっくり（おちょこ付き）")
      (#xE74C . "どんぶり")
      (#xE74D . "パン")
      (#xE74E . "かたつむり")
      (#xE74F . "ひよこ")
      (#xE750 . "ペンギン")
      (#xE751 . "魚")
      (#xE752 . "うまい！")
      (#xE753 . "ウッシッシ")
      (#xE754 . "ウマ")
      (#xE755 . "ブタ")
      (#xE756 . "ワイングラス")
      (#xE757 . "げっそり")
      (#xE600 . "人差し指")
      )))


;; Interface functions
(defun mime-emoji/docomo-display-string (string)
  (let (elt)
    (dotimes (i (length string))
      (setq elt (mime-emoji/docomo-get (string-to-char (substring string i))))
      (when elt
	(add-text-properties i (1+ i) `(display ,elt) string))))
  string)

(defun mime-emoji/docomo-display-region (start end)
  (dotimes (i (- end start))
    (let ((elt (mime-emoji/docomo-get (char-after (+ start i)))))
      (when elt
	(add-text-properties (+ start i) (+ start i 1) `(display ,elt))))))

;; Internal functions
(defun mime-emoji/docomo-get (char)
  (let ((elt (assq char mime-emoji/docomo-list)))
    (when elt
      (mime-emoji-get-emoji 'docomo (number-to-string (car elt)) (cdr elt)))))


(provide 'mime-emoji-docomo)
;;; mime-emoji-docomo.el ends here
