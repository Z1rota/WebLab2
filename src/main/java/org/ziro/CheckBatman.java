package org.ziro;

public class CheckBatman {
    private double x,y,r,temp;

        public CheckBatman(double x, double y, double r) {
            this.x = x;
            this.y = y;
            this.r = r;
            temp = -Math.sqrt((r / 2 * r / 2 * (r * r - r / 2 * r / 2) / (r * r)));
        }

        public boolean checkWings() {
            return (x / r) * (x / r) + (2 * y / r) * (2 * y / r) <= 1;
        }

        public boolean check4Tail() {
            //чек правого нижнего овала
            return Math.pow(x - 3 * r / 8, 2) / Math.pow(r / 8, 2)
                    + Math.pow(y - temp, 2) / Math.pow(r / 5, 2) < 1;
        }

        public boolean check1Tail() {
            //чек правого нижнего овала
            return Math.pow(x + 3 * r / 8, 2) / Math.pow(r / 8, 2)
                    + Math.pow(y - temp, 2) / Math.pow(r / 5, 2) < 1;
        }

        public boolean check1Shoulder() {
            // чек левого верхнего овала
            return Math.pow(x + 5 * r / 16, 2) / Math.pow(3 * r / 16, 2)
                    + Math.pow(y + temp, 2) / Math.pow(r / 5, 2) < 1;
        }

        public boolean check2Shoulder() {
            // чек правого верхнего овала
            return Math.pow(x - 5 * r / 16, 2) / Math.pow(3 * r / 16, 2)
                    + Math.pow(y + temp, 2) / Math.pow(r / 5, 2) < 1;
        }

        public boolean checkMask() {
            // проверка маски на голове
            return y > -temp - r / 5
                    && (x + r / 8) / (r / 16) - (y + temp) / (-r / 5) > 0
                    && (x - r / 8) / (-r / 16) - (y + temp) / (-r / 5) > 0;
        }

        public boolean check3Tail() {
            //а сейчас проверка закрученных
            double alpha = -0.01;
            double nx = Math.cos(alpha) * x + Math.sin(alpha) * y;
            double ny = -x * Math.sin(alpha) + Math.cos(alpha) * y;

            return Math.pow(nx - r / 8, 2) / Math.pow(r / 8, 2)
                    + Math.pow(ny - temp, 2) / Math.pow(r / 4, 2) < 1;
        }

        public boolean check2Tail() {
            double alpha = 0.01;
            double nx = Math.cos(alpha) * x + Math.sin(alpha) * y;
            double ny = -x * Math.sin(alpha) + Math.cos(alpha) * y;
            return Math.pow(nx + r / 8, 2) / Math.pow(r / 8, 2)
                    + Math.pow(ny - temp, 2) / Math.pow(r / 4, 2) < 1;
        }

        public boolean getResult() {
            return checkWings()
                    && !(check1Tail() || check2Tail() || check3Tail() || check4Tail()
                    || checkMask() || check1Shoulder() || check2Shoulder());
        }

}
