# -*- coding: utf-8 -*-
"""
vi_du_doc_excel.py — CONG CU MAU (chay duoc ngay)
==================================================
Muc dich:
  - Doc TAT CA file Excel trong thu muc file_can_xu_ly/
  - In cau truc: ten file, ten sheet, so dong, so cot, ten cot, kieu du lieu
  - Kiem tra so bo: o trong, dong trung, loi cong thuc
  - Xuat mot file bao cao .xlsx vao file_da_xu_ly/ (ten co ngay gio)
  - Ghi log vao logs/

Tuan thu AGENTS.md:
  - KHONG sua / ghi de file trong file_can_xu_ly (chi doc)
  - KHONG xoa file
  - Moi ket qua tao file MOI trong file_da_xu_ly, ten co ngay gio
  - In tien do bang tieng Viet, co xu ly loi
  - Log chi ghi ten file / so dong / thoi gian / trang thai (khong ghi noi dung nhay cam)

Cach chay:
  - Bam dup file scripts/RUN.cmd
  - Hoac: python scripts/vi_du_doc_excel.py
"""

from __future__ import annotations

import sys
import traceback
from datetime import datetime
from pathlib import Path

# --- Xac dinh cac thu muc theo vi tri file script (khong hardcode o dia) ---
ROOT = Path(__file__).resolve().parent.parent
INPUT_DIR = ROOT / "file_can_xu_ly"
OUTPUT_DIR = ROOT / "file_da_xu_ly"
LOGS_DIR = ROOT / "logs"

# Thong tin cong cu
TAC_GIA = "Phan Nam"
PHIEN_BAN = "1.0.0"

# Cac duoi file Excel duoc chap nhan
EXCEL_EXTS = {".xlsx", ".xlsm", ".xls"}

# Thoi diem chay, dung cho ten file va log
NOW = datetime.now()
STAMP = NOW.strftime("%Y-%m-%d_%H-%M-%S")

LOG_FILE = LOGS_DIR / f"vi_du_doc_excel_{STAMP}.log"


def ghi_log(dong: str) -> None:
    """Ghi mot dong log kem thoi gian. Chi ghi thong tin an toan."""
    thoi_gian = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    LOGS_DIR.mkdir(parents=True, exist_ok=True)
    with LOG_FILE.open("a", encoding="utf-8") as f:
        f.write(f"[{thoi_gian}] {dong}\n")


def in_va_log(dong: str) -> None:
    """In ra man hinh (tieng Viet) va ghi log cung luc."""
    print(dong)
    ghi_log(dong)


def kiem_tra_thu_vien() -> tuple:
    """Kiem tra pandas/openpyxl da cai chua. Tra ve (pandas, openpyxl)."""
    try:
        import pandas as pd  # noqa: WPS433
        import openpyxl  # noqa: F401,WPS433
    except ImportError as loi:
        in_va_log(
            "[LOI] Thieu thu vien can thiet: "
            f"{loi.name}. Hay chay bo cai dat de cai:\n"
            "       - Windows: 01_CAI_DAT_CONG_CU.bat\n"
            "       - macOS:   macos/01_cai_dat.command"
        )
        sys.exit(1)
    return pd, openpyxl


def tim_file_excel() -> list:
    """Tra ve danh sach file Excel trong file_can_xu_ly/ (chi trong thu muc du an)."""
    if not INPUT_DIR.exists():
        INPUT_DIR.mkdir(parents=True, exist_ok=True)
    files = [
        p for p in sorted(INPUT_DIR.iterdir())
        if p.is_file() and p.suffix.lower() in EXCEL_EXTS
    ]
    return files


def phan_tich_file(pd, duong_dan: Path) -> list:
    """
    Doc mot file Excel va tra ve danh sach dong bao cao (mot dong/moi sheet).
    KHONG ghi gi vao file goc.
    """
    ket_qua = []
    try:
        xls = pd.ExcelFile(duong_dan)  # chi doc
    except Exception as loi:  # noqa: BLE001
        in_va_log(f"[LOI] Khong doc duoc file '{duong_dan.name}': {loi}")
        ket_qua.append({
            "File": duong_dan.name,
            "Sheet": "(khong doc duoc)",
            "So dong": 0,
            "So cot": 0,
            "Ten cot": "",
            "O trong": 0,
            "Dong trung": 0,
            "Loi cong thuc": 0,
            "Ghi chu": f"Loi doc file: {loi}",
        })
        return ket_qua

    for ten_sheet in xls.sheet_names:
        try:
            df = xls.parse(ten_sheet)
        except Exception as loi:  # noqa: BLE001
            in_va_log(
                f"[CANH BAO] Khong doc duoc sheet '{ten_sheet}' "
                f"trong '{duong_dan.name}': {loi}"
            )
            continue

        so_dong = int(df.shape[0])
        so_cot = int(df.shape[1])
        ten_cot = ", ".join(str(c) for c in df.columns)
        kieu_du_lieu = ", ".join(f"{c}={t}" for c, t in df.dtypes.items())

        o_trong = int(df.isna().sum().sum())
        dong_trung = int(df.duplicated().sum())

        # Dem loi cong thuc Excel dang chuoi (#N/A, #REF!, #DIV/0! ...)
        loi_cong_thuc = 0
        for cot in df.columns:
            cot_str = df[cot].astype(str)
            loi_cong_thuc += int(
                cot_str.str.contains(
                    r"#(N/A|REF!|DIV/0!|VALUE!|NAME\?|NULL!|NUM!)",
                    regex=True, na=False,
                ).sum()
            )

        in_va_log(
            f"[OK] {duong_dan.name} / sheet '{ten_sheet}': "
            f"{so_dong} dong, {so_cot} cot"
        )
        in_va_log(f"      Cot: {ten_cot}")
        in_va_log(f"      Kieu du lieu du kien: {kieu_du_lieu}")
        if o_trong:
            in_va_log(f"      [CANH BAO] Co {o_trong} o trong")
        if dong_trung:
            in_va_log(f"      [CANH BAO] Co {dong_trung} dong trung")
        if loi_cong_thuc:
            in_va_log(f"      [CANH BAO] Co {loi_cong_thuc} o loi cong thuc")

        ket_qua.append({
            "File": duong_dan.name,
            "Sheet": ten_sheet,
            "So dong": so_dong,
            "So cot": so_cot,
            "Ten cot": ten_cot,
            "O trong": o_trong,
            "Dong trung": dong_trung,
            "Loi cong thuc": loi_cong_thuc,
            "Ghi chu": "",
        })
    return ket_qua


def main() -> int:
    in_va_log("============================================================")
    in_va_log("CONG CU MAU: Doc va mo ta cau truc file Excel")
    in_va_log(f"Script created by {TAC_GIA}  -  Version {PHIEN_BAN}")
    in_va_log(f"Thu muc du an: {ROOT}")

    pd, _ = kiem_tra_thu_vien()

    files = tim_file_excel()
    if not files:
        in_va_log(
            "[CANH BAO] Khong tim thay file Excel nao trong thu muc 'file_can_xu_ly'.\n"
            "           Hay copy file .xlsx vao thu muc file_can_xu_ly roi chay lai."
        )
        return 0

    in_va_log(f"Tim thay {len(files)} file Excel trong file_can_xu_ly.")

    tat_ca = []
    for f in files:
        in_va_log("------------------------------------------------------------")
        in_va_log(f"[DANG DOC] {f.name}")
        tat_ca.extend(phan_tich_file(pd, f))

    # --- Xuat bao cao ra file_da_xu_ly (file moi, ten co ngay gio) ---
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    file_ket_qua = OUTPUT_DIR / f"bao_cao_cau_truc_{STAMP}.xlsx"
    try:
        df_out = pd.DataFrame(tat_ca)
        with pd.ExcelWriter(file_ket_qua, engine="openpyxl") as writer:
            df_out.to_excel(writer, sheet_name="BAO_CAO", index=False)
        in_va_log("------------------------------------------------------------")
        in_va_log(f"[OK] Da xuat bao cao: {file_ket_qua.name}")
    except Exception as loi:  # noqa: BLE001
        in_va_log(f"[LOI] Khong xuat duoc bao cao: {loi}")
        return 1

    # --- Bao cao tong ket theo AGENTS.md ---
    tong_dong_doc = sum(r["So dong"] for r in tat_ca)
    in_va_log("============================================================")
    in_va_log("KET QUA:")
    in_va_log(f"  - So file doc: {len(files)}")
    in_va_log(f"  - So sheet phan tich: {len(tat_ca)}")
    in_va_log(f"  - Tong so dong da doc: {tong_dong_doc}")
    in_va_log(f"  - File dau ra: {file_ket_qua}")
    in_va_log(f"  - Log: {LOG_FILE}")
    in_va_log("  - Gia dinh: dong dau tien moi sheet la tieu de cot (mac dinh pandas).")
    in_va_log("  - Luu y: file goc trong file_can_xu_ly KHONG bi thay doi.")
    in_va_log("============================================================")
    return 0


if __name__ == "__main__":
    try:
        ma_thoat = main()
    except KeyboardInterrupt:
        in_va_log("[CANH BAO] Nguoi dung da dung chuong trinh.")
        ma_thoat = 1
    except Exception:  # noqa: BLE001
        in_va_log("[LOI] Da xay ra loi khong mong doi:")
        in_va_log(traceback.format_exc())
        ma_thoat = 1
    sys.exit(ma_thoat)
