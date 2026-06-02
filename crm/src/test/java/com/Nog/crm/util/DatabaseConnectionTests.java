package com.Nog.crm.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@SpringBootTest
public class DatabaseConnectionTests {

    @Autowired
    private DataSource dataSource;

    private static final Logger logger = LoggerFactory.getLogger(DatabaseConnectionTests.class);

    @Test
    void testConnection() throws SQLException {
        assertThat(dataSource).isNotNull();

        try (Connection connection = dataSource.getConnection()) {
            assertThat(connection.isValid(2));

        }
    }


}
