import qrcode
import argparse
import sys

def generate_qr():
    # Setup argument parser
    parser = argparse.ArgumentParser(description="Generate a QR code from a string or URL.")

    # Positional argument for the content
    parser.add_argument("content", help="The text or URL to encode into the QR code")

    # Optional argument for the output file
    parser.add_argument("-o", "--output", default="qrcode.png",
                        help="The filename for the saved PNG (default: qrcode.png)")

    args = parser.parse_args()

    try:
        # Configure the QR code settings
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_H,
            box_size=10,
            border=4,
        )

        qr.add_data(args.content)
        qr.make(fit=True)

        # Create and save the image
        img = qr.make_image(fill_color="black", back_color="white")
        img.save(args.output)

        print(f"✅ Success! QR code for '{args.content}' saved to '{args.output}'")

    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    generate_qr()
