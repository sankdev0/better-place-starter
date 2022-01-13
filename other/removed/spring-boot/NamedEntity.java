package com.sankdev.fluffybest.entity;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import lombok.Data;

/**
 * Simple JavaBean domain object adds a name property to <code>BaseEntity</code>. Used as
 * a base class for objects needing these properties.
 *
 */
@MappedSuperclass
@Data
public class NamedEntity extends BaseEntity {

  @Column(name = "name")
  private String name;
}
