package tn.m104.rh.entity;

import javax.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;


@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
            // you should say my name again
    Integer rollNumber;
    String name;
    String address;
    Double percentage;

}
