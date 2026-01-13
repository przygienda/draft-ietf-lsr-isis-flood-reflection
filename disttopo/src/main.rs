use fletcher::calc_fletcher16;

fn main() {
    let ids : [[u8; _]; _] = [
        [ 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x00, 0x00, ],
        [ 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x00, 0x07, ],
        [ 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x00, 0x0f, ],
        [ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x00, 0x01, ],
    ];

    for id_ in &ids {
        let mut cid = id_.clone();
        cid[7] >>= 3;
        let csum = calc_fletcher16(&cid);

        println!("{:02X}{:02X}.{:02X}{:02X}.{:02X}{:02X}.{:02X}.{:02X} checksum: ${:04X} mod%(2,3,4,5,6) {:02},{:02},{:02},{:02},{:02}",
        id_[0], id_[1], id_[2], id_[3], id_[4], id_[5], id_[6], id_[7], csum, csum%2, csum%3, csum%4, csum%5, csum%6);
    }
}
