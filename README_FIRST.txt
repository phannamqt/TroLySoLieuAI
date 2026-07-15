###########################################################
#                                                         #
#   TRO LY SO LIEU AI - DOC FILE NAY DAU TIEN               #
#                                                         #
###########################################################

CHAO BAN!

Day la bo cong cu giup ban xu ly file Excel bang tieng Viet,
KHONG can biet lap trinh.

-----------------------------------------------------------
  CACH DE NHAT: BAM DUP FILE KHOI DONG O DAY
-----------------------------------------------------------

  >>> NEU DUNG WINDOWS:
    - Bam dup file:  WINDOW_BAT_DAU.bat
    - Se hien MENU. Chon so:
        [1] Cai dat  (chi lam LAN DAU, can Run as administrator)
        [2] Kiem tra moi truong
        [3] Mo cong cu AI
    - Lan dau: chon [1], cho den khi thay "CAI DAT HOAN TAT!".

  >>> NEU DUNG macOS:
    - Bam dup file:  MAC_BAT_DAU.command
    - Neu bi chan: CHUOT PHAI file -> Open -> Open.
    - Se hien MENU. Chon so [1] de cai dat lan dau.
    - Co the se hoi mat khau may khi cai Homebrew.

-----------------------------------------------------------
  DUNG HANG NGAY
-----------------------------------------------------------

  1. Bo file Excel vao thu muc:  input
  2. Mo cong cu:
       - Windows: bam dup WINDOW_BAT_DAU.bat -> chon [3]
       - macOS:   bam dup MAC_BAT_DAU.command -> chon [3]
     (hoac dung shortcut "Tro Ly So Lieu AI" tren Desktop)
  3. Trong VS Code, mo Codex:
       - Windows: Ctrl+Shift+X    - macOS: Cmd+Shift+X
     (tim tu khoa "Codex" de cai neu chua co).
  4. Dang nhap Codex bang TAI KHOAN CONG TY cap.
  5. Mo file:  PROMPT_MAU.md  -> copy 1 prompt -> sua yeu cau -> gui.
  6. Xem ket qua trong thu muc:  output

-----------------------------------------------------------
  CAC FILE QUAN TRONG
-----------------------------------------------------------

  WINDOW_BAT_DAU.bat        -> BAT DAU tren Windows (bam dup dau tien)
  MAC_BAT_DAU.command       -> BAT DAU tren macOS (bam dup dau tien)

  (Windows - trong thu muc windows/)
  01_CAI_DAT_CONG_CU.bat    -> Cai dat cong cu
  02_KIEM_TRA_MOI_TRUONG.bat-> Kiem tra moi truong
  03_MO_CONG_CU_AI.cmd      -> Mo cong cu hang ngay
  04_GO_CAI_DAT.bat         -> Go cai dat (khi khong dung nua)

  (macOS - trong thu muc macos/)
  01_cai_dat.command        -> Cai dat cong cu
  02_kiem_tra.command       -> Kiem tra moi truong
  03_mo_cong_cu.command     -> Mo cong cu hang ngay
  04_go_cai_dat.command     -> Go cai dat (khi khong dung nua)

  (Dung chung)
  HUONG_DAN_SU_DUNG.md      -> Huong dan chi tiet tung buoc
  PROMPT_MAU.md             -> Cac cau lenh mau cho Codex
  AGENTS.md                 -> Quy tac cho AI (danh cho nguoi bao tri)

-----------------------------------------------------------
  CAN GIUP DO?
-----------------------------------------------------------

  - Doc file:  HUONG_DAN_SU_DUNG.md
  - Hoac lien he nguoi phu trach cong cu.

  LUU Y BAO MAT: Khong dua du lieu nhay cam vao cong cu
  neu chua duoc cong ty cho phep.

###########################################################
