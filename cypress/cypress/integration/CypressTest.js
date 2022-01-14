Cypress.on('uncaught:exception', (err, runnable) => {
    // returning false here prevents Cypress from
    // failing the test
    return false
  })



describe('feedback form test', () => {
    it('send feedback form after enter valid data ', () => {
            cy.visit('https://www.globalsqa.com/samplepagetest/')
            cy.get('#g2599-name').type("admin")
            cy.get('#g2599-email').type("admin@gmail.com")
            cy.get('#g2599-website').type("https://www.globalsqa.com/")
            cy.get('.grunion-field-checkbox-multiple-wrap > :nth-child(2)').click()
            cy.get(':nth-child(6) > .checkbox-multiple').click()
            cy.get('#contact-form-comment-g2599-comment').type("Comment")
            cy.get('.pushbutton-wide').click()
            cy.url().should('include', '#contact-form') // => true
            cy
                .get('.contact-form-submission > :nth-child(1)')
                .should('have.text', 'Name: admin')
            cy
                .get('.contact-form-submission > :nth-child(2)')
                .should('have.text', 'Email: admin@gmail.com')
            cy
                .get('.contact-form-submission > :nth-child(3)')
                .should('have.text', 'Website: https://www.globalsqa.com/')  
        })
});

describe('feedback form test', () => {
    it('send feedback form  field with punctuation marks and  incorrect data', () => {
            cy.visit('https://www.globalsqa.com/samplepagetest/')
            cy.get('#g2599-name').type("!!!!???admin")
            cy.get('#g2599-email').type("!!!!???admin@gmail.com")
            cy.get('#g2599-website').type("!!!!???https://www.globalsqa.com/")
            cy.get('.grunion-field-checkbox-multiple-wrap > :nth-child(2)').click()
            cy.get('#contact-form-comment-g2599-comment').type("!!!???omment")
            cy.get('.pushbutton-wide').click()

            cy.url().should('eq', 'https://www.globalsqa.com/samplepagetest/'); 
            
        })
    })
        
            



